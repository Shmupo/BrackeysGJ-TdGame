extends Button

func _ready() -> void:
	pressed.connect(onPressed)


func onPressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
