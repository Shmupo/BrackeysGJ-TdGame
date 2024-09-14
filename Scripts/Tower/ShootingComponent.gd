class_name ShootingComponent
extends Node2D

# testing placeholder
var projectileInstance: PackedScene = load("res://Scenes/Components/Tower/Projectile/TestProjectile1.tscn")
var numProjectiles: int = 1

@onready var tower: Tower = get_owner()

## TODO : May need to mutex lock upgrades to disable stat changes while going through loops

# reset to base values
func reset() -> void:
	numProjectiles = 1
	projectileInstance = load("res://Scenes/Components/Tower/Projectile/TestProjectile1.tscn")

func getMods() -> Array[ModItem]:
	return tower.getMods()

# This will create a projectile that is linked to the target
func fireProjectile(targets: Array) -> void:
	#print("Fired projectile")
	var projectiles: Array = []

	# This loop will allow multiple projectiels to be fired, BUT the same target cannot be shot at twice
	var targetIdx: int = 0
	for num in numProjectiles:
		var newProjectile: Node2D = projectileInstance.instantiate()
		add_child(newProjectile)
		newProjectile.position.y -= 10
		newProjectile.global_position = global_position
		newProjectile.setTarget(targets[targetIdx])
		projectiles.append(newProjectile)
		if targetIdx < targets.size() - 1:
			targetIdx += 1
		else:
			break

	#print("projectile speed before: " + str(newProjectile.projectileSpeed))
	#print("projectile damage before: " + str(newProjectile.projectileDamage))

	# TODO : Maybe optimize this? -not a big deal
	# loop over all upgrades and apply to projectile
	for projectile in projectiles:
		for upgrade in tower.upgrades:
			upgrade.apply_upgrade(projectile)
		for mod in getMods(): # separate upgrade system
			mod.applyProjectileUpgrades(projectile)

	#print("projectile speed after: " + str(newProjectile.projectileSpeed))
	#print("projectile damage after: " + str(newProjectile.projectileDamage))
