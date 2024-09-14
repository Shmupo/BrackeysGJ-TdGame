class_name SimpleTowerProjectile
extends Node2D

var projectileSpeed: float = 500
var projectileDamage: float = 1
var target: Node2D
var moving: bool = false

# once doing this, this projectile will go towards the target
func setTarget(newTarget: Node2D) -> void:
	target = newTarget
	moving = true

func _process(delta: float) -> void:
	if moving:
		if target == null or !is_instance_valid(target):
			queue_free() # delete if target disappears
			return
		global_position = global_position.move_toward(target.global_position, delta * projectileSpeed)
		if global_position == target.global_position:
			
			if target.get_parent().is_in_group("EnemyGroup"):
				target.get_parent().removeHealth(projectileDamage)
			
			queue_free()
