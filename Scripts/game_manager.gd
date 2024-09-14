class_name GameManager
extends Node


@onready var defeat_screen: CanvasLayer = %DefeatScreen
@onready var player: Player = %Player

var already_defeated: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func defeat() -> void:
	if already_defeated:
		return
		
	already_defeated = true
	defeat_screen.visible = true
	var ds: DefeatSprite = defeat_screen.get_node("DefeatSprite")
	ds.start_animation()
