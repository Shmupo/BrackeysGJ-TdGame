extends Area2D


@onready var player = %Player


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("EnemyGroup"):
		var entity: Entity = area.get_parent()
		entity.hit_base()
		
