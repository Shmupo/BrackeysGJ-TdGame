extends Node

signal _on_wave_start
signal _on_wave_end

@export var num_entities: int = 10
@export var spawn_timer_wait_time: float = 0.75
@export var entity_name: String = "BaseEntity"

@onready var EntityManager = %EntityManager
@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	spawn_timer.wait_time = spawn_timer_wait_time

func start_wave() -> void:
	print("wave_start")
	_on_wave_start.emit()
	spawn_timer.start()
	
	
func spawn_next() -> void:
	EntityManager.spawnEntity(entity_name)
	num_entities -= 1
	if (num_entities < 0):
		end_wave()
	

func end_wave() -> void:
	print("wave_end")
	spawn_timer.stop()
	_on_wave_end.emit()
	queue_free()
