extends Label

@onready var player = %Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("on_take_damage", _on_take_damage)
	text = str(player.player_health)


func _on_take_damage(num_points: int, total_health: int) -> void:
	text = str(total_health)
