class_name AOEProjectile
extends SimpleTowerProjectile

@onready var area: Area2D = $Area2D

func _process(delta: float) -> void:
	if moving:
		if target == null or !is_instance_valid(target):
			queue_free() # delete this projectile if the original target is gone
			return
		global_position = global_position.move_toward(target.global_position, delta * projectileSpeed)
		if global_position == target.global_position:
			
			var enemiesInArea: Array = area.get_overlapping_areas()

			for areaTarget in enemiesInArea:
				if areaTarget.get_parent().is_in_group("EnemyGroup"):
					areaTarget.get_parent().removeHealth(projectileDamage)
			
			queue_free()
