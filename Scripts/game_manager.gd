class_name GameManager
extends Node


@onready var defeat_screen: CanvasLayer = %DefeatScreen
@onready var player: Player = %Player
@onready var waveManager: WaveManager = %WaveManager

var already_defeated: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func defeat() -> void:
	if already_defeated:
		return
	
	if waveManager.currentWave < 6:
		already_defeated = true
		defeat_screen.visible = true
		var ds: DefeatSprite = defeat_screen.get_node("DefeatSprite")
		ds.start_animation()
	else: # player is on the storm phase, display the end of the game spash screen
		get_tree().change_scene_to_file("res://Scenes/GameEndScreen.tscn")
