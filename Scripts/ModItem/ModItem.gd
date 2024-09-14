class_name ModItem
extends Node2D

@export_group("Stat Modifiers")
@export var projectileSpeedAdd: float = 0
@export var projectileCountAdd: int = 0
@export var projectileDamageAdd: float = 0
@export var fireRateAddTime: float = 0
@export var newProjectileScene: PackedScene = null
@export var targetRangeAdd: float = 0

@export_group("Names")
@export var itemName: String = "Test"
@export var itemDescription: String = "TestDescription"

@onready var dragComponent: Node2D = $DragComponent

# DIRECT TOWER UPGRADES
# 1-Time change to a tower
func applyTowerUpgrades(tower: Tower) -> void:
	addProjectileCount(tower)
	changeProjectile(tower)
	addTargetingRange(tower)
	addFireRate(tower)


# shoot more projectiles
func addProjectileCount(tower: Tower) -> void:
	tower.shootingComponent.numProjectiles += projectileCountAdd


# increase targeting circle
func addTargetingRange(tower: Tower) -> void:
	tower.targetingComponent.targetingRadius += targetRangeAdd


func addFireRate(tower: Tower) -> void:
	tower.fireDelaySeconds  += fireRateAddTime


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

func getTexture() -> Texture:
	return $ItemSprite2D.texture
