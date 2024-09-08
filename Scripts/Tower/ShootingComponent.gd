class_name ShootingComponent
extends Node2D

# testing placeholder
var projectileInstancePath: String = "res://Scenes/Components/Tower/Projectile/TestProjectile1.tscn"

# This will create a projectile that is linked to the target
func fireProjectile(target: Node2D) -> void:
	#print("Fired projectile")
	var newProjectile: Node2D = load(projectileInstancePath).instantiate()
	add_child(newProjectile)
	newProjectile.global_position = global_position
	newProjectile.setTarget(target)
