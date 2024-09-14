extends Label

@onready var player = %Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("on_earn_points", _on_earn_points)
	text = str(player.player_points)


func _on_earn_points(num_points: int, total_points: int) -> void:
	text = str(total_points)
