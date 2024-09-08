extends Node2D

var projectileSpeed: float = 500
var target: Node2D
var moving: bool = false

# once doing this, this projectile will go towards the target
func setTarget(newTarget: Node2D) -> void:
	target = newTarget
	moving = true

func _process(delta: float) -> void:
	if moving:
		global_position = global_position.move_toward(target.global_position, delta * projectileSpeed)
		if global_position == target.global_position:
			# For now, simply delete the projectile
			queue_free()
