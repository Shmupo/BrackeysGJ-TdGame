class_name Player
extends Node

signal on_earn_points
signal on_take_damage
signal on_defeat

@export var player_points: int = 0: set = update_points
@export var player_health: int = 100


func _ready() -> void:
	update_points(player_points)
	take_damage(0)

func add_points(num_points: int) -> void:
	update_points(player_points + num_points)


func update_points(num_points: int) -> void:
	player_points = num_points
	on_earn_points.emit(num_points, player_points)


func take_damage(num_points: int) -> void:
	player_health = player_health - num_points
	on_take_damage.emit(num_points, player_health)
	if player_health < 1:
		# TODO you lost
		on_defeat.emit()
