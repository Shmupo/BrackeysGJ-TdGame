extends Node

@onready var startButton: Button = $CenterContainer/VBoxContainer/StartButton
@onready var blackoutSquare: ColorRect = $ColorRect

func _ready() -> void:
	startButton.button_up.connect(onStartPressed)
	blackoutSquare.color = Color.BLACK
	
func onStartPressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TestScene.tscn")
	
func _process(delta: float) -> void:
	var new_alpha = clamp(blackoutSquare.color.a - 1 * delta, 0.0, 255.0) # alpha is between 0 and 1
	var new_color = blackoutSquare.color
	new_color.a = new_alpha
	blackoutSquare.color = new_color
