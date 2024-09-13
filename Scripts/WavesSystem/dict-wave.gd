class_name DictWave
extends Wave

#@onready var timer: Timer = $Timer

@export var spawn_queue: Array[Dictionary] = [
	{
		"type": "BaseEntity",
		"spawn_delay": 0.1,
		"config": {
			"speed": 100,
			"health": 20
		}
	},
	{
		"type": "OtherEntity",
		"spawn_delay": 0.5,
		"config": {
			"speed": 15,
			"health": 20,
			"example_property": 15
		}
	}
] 

func get_num_entities() -> int:
	var answer = spawn_queue.size()
	if timer != null && !timer.is_stopped():
		answer += 1
	return answer

func _ready() -> void: 
	#spawn_timer.wait_time = spawn_timer_wait_time
	pass

func start_wave() -> void:
	print("wave_start")
	_on_wave_start.emit()
	spawn_next()


func spawn_next() -> void:
	if spawn_queue.size() < 1:
		end_wave()
		return
	
	var next = spawn_queue.pop_front()
	# set up timer
	timer.reparent($'.')
	timer.wait_time = next["spawn_delay"]
	timer.connect("timeout", Callable(do_spawn).bind(next).call)
	timer.one_shot = true
	timer.start()
	
	
func do_spawn(spawn_dict: Dictionary) -> void:
	var entity: Entity = EntityManager.spawnEntity(
		spawn_dict["type"], 
		spawn_dict["config"])
		
	# Disconnect callable for spawning previous enemy
	for dict in timer.get_signal_list():
		for sig in timer.get_signal_connection_list(dict.name):
			timer.disconnect(sig.signal.get_name(), sig.callable)
	
	spawn_next()
	

func end_wave() -> void:
	print("wave_end")
	timer.stop()
	_on_wave_end.emit()
	queue_free()
