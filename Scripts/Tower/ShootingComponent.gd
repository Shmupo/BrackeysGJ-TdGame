class_name ShootingComponent
extends Node2D

# testing placeholder
var projectileInstancePath: String = "res://Scenes/Components/Tower/Projectile/TestProjectile1.tscn"


var damage: float = 1

@onready var tower: Tower = get_owner()


# This will create a projectile that is linked to the target
func fireProjectile(target: Node2D) -> void:
	#print("Fired projectile")
	var newProjectile: Node2D = load(projectileInstancePath).instantiate()
	add_child(newProjectile)
	newProjectile.global_position = global_position
	newProjectile.setTarget(target)
	
	print("projectile speed before: " + str(newProjectile.projectileSpeed))
	print("projectile damage before: " + str(newProjectile.projectileDamage))
	
	# loop over all upgrades and apply to projectile
	for upgrade in tower.upgrades:
		upgrade.apply_upgrade(newProjectile)
		
	print("projectile speed after: " + str(newProjectile.projectileSpeed))
	print("projectile damage after: " + str(newProjectile.projectileDamage))
