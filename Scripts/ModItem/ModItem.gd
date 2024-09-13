class_name ModItem
extends Node2D

var itemName: String = "TEST"

@export_group("Stat Modifiers")
@export var projectileSpeedAdd: float = 0
@export var projectileCountAdd: int = 0
@export var projectileDamageAdd: float = 0
@export var newProjectileScene: PackedScene = null
@export var targetRangeAdd: float = 0


# DIRECT TOWER UPGRADES
# 1-Time change to a tower
func applyTowerUpgrades(tower: Tower) -> void:
	addProjectileCount(tower)
	changeProjectile(tower)


# shoot more projectiles
func addProjectileCount(tower: Tower, reverse: bool = false) -> void:
	tower.shootingComponent.numProjectiles += projectileCountAdd


# increase targeting circle
func addTargetingRange(tower: Tower, reverse: bool = false) -> void:
	tower.targetingComponent.targetingRadius += targetRangeAdd


# changes the projectile to something else completely
# this can be used to change how the projectile travels or behaves
func changeProjectile(tower: Tower) -> void:
	if newProjectileScene != null:
		tower.shootingComponent.projectileInstance = newProjectileScene


# PROJECTILE FILTERS
# Apply changes to a projectile every time one passes through
func applyProjectileUpgrades(projectile: SimpleTowerProjectile) -> void:
	addProjectileSpeed(projectile)
	addProjectileDamage(projectile)


func addProjectileSpeed(projectile: SimpleTowerProjectile) -> void:
	projectile.projectileSpeed += projectileSpeedAdd


func addProjectileDamage(projectile: SimpleTowerProjectile) -> void:
	projectile.projectileDamage += projectileDamageAdd
