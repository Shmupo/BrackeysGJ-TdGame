extends Node2D

signal _on_wave_start
signal _on_wave_end
signal _on_start_waves
signal _on_end_waves


@onready var EntityManager = %EntityManager
@onready var wave_set: Node = $WaveSet
@onready var active_waves: Node = $ActiveWaves
@onready var wave_timer: Timer = $WaveTimer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wave_timer.one_shot = true
	


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


func _on_start_wave_button_pressed() -> void:
	pass # Replace with function body.
