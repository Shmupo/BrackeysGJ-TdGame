class_name Wave
extends Node


signal _on_wave_start
signal _on_wave_end

@export var num_entities: int: get = get_num_entities
@export var spawn_timer_wait_time: float = 0.75
@export var entity_name: String = "BaseEntity"

@onready var EntityManager = %EntityManager
@onready var timer: Timer = $Timerz


func get_num_entities() -> int:
	return num_entities

func _ready() -> void:
	if timer == null:
		timer = Timer.new()
		timer.name = "Timer"
		add_child(timer)
		
	timer.wait_time = spawn_timer_wait_time

func start_wave() -> void:
	print("wave_start")
	_on_wave_start.emit()
	timer.connect("timeout", spawn_next)
	timer.start()
	
	
func spawn_next() -> void:
	EntityManager.spawnEntity(entity_name)
	num_entities -= 1
	if (num_entities < 0):
		end_wave()
	

func end_wave() -> void:
	print("wave_end")
	timer.stop()
	_on_wave_end.emit()
	queue_free()
