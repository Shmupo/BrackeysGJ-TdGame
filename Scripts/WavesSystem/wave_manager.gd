class_name WaveManager
extends Node2D

signal _on_wave_start
signal _on_wave_end
signal _on_start_waves
signal _on_end_waves


@onready var EntityManager = %EntityManager
@onready var wave_set: Node = $WaveSet
@onready var active_waves: Node = $ActiveWaves
@onready var wave_timer: Timer = $WaveTimer

var num_entities: int: get = get_num_entities

@export var time_between_waves: float = 5.0

var currentWave: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if wave_timer == null:
		wave_timer = Timer.new()
		add_child(wave_timer)
	
	wave_timer.wait_time = time_between_waves
	wave_timer.one_shot = true
	

func startNextWave() -> void:
	wave_timer.stop()
	
	if wave_set.get_child_count() < 1:
		end_waves()
		return
	
	var next_wave = wave_set.get_child(0)
	
	next_wave.reparent(active_waves)
	next_wave.connect("_on_wave_end", waveEnd)
	next_wave.start_wave()
	_on_wave_start.emit()
	
func waveEnd() -> void:
	_on_wave_end.emit()

func begin_waves() -> void:
	print("start_waves")
	_on_start_waves.emit()
	begin_next_wave()
	
	
func begin_next_wave() -> void:
	wave_timer.stop()
	
	if wave_set.get_child_count() < 1:
		end_waves()
		return
	
	var next_wave = wave_set.get_child(0)
	
	next_wave.reparent(active_waves)
	next_wave.connect("_on_wave_end", on_wave_end)
	next_wave.start_wave()
	_on_wave_start.emit()
	
	
func on_wave_end() -> void:
	_on_wave_end.emit()
	wave_timer.start()
	
	
func end_waves() -> void:
	print("end_waves")
	_on_end_waves.emit()


func get_num_entities() -> int:
	var num = 0
	for wave in $ActiveWaves.get_children():
		num += wave.num_entities
	return num


func _on_start_wave_button_pressed() -> void:
	pass # Replace with function body.
