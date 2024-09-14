class_name Tower
extends Node2D

## Tower is the base class of a tower defence tower
##
## This script controls when the tower will fire
##
## targetingComponent controls what this tower fires at and is used to get the targets
## shootingComponent controls what projectile the tower shoots and the damage the projectile deals
## modsComponent manages the mods - stores the mods and applies them to this tower's stats

@onready var targetingComponent: TargetingComponent = $TargetingComponent
@onready var shootingComponent: ShootingComponent = $ShootingComponent
@onready var modsComponent: ModsComponent = $ModsComponent
@onready var towerDragComponent: TowerDragComponent = $TowerDragComponent

# if this timer is counting, do not fire
@onready var fireTimer: Timer = $FireTimer

# fires after this amount of time has passed
@export var fireDelaySeconds: float = 0.5 : set = setFireDelay
var firing: bool = false

var towerName: String = "TestTower1"

# array of projectile upgrades to be applied
var upgrades: Array[BaseProjectileStrategy] = []


func _ready() -> void:
	targetingComponent.areaEntered.connect(onTargetAreaEntered) 
	fireTimer.wait_time = fireDelaySeconds
	fireTimer.timeout.connect(onFireTimerTimeout)
	var newShape: CircleShape2D = CircleShape2D.new()
	newShape.radius = 50
	$TargetingArea2D/CollisionShape2D.shape = newShape


func fire() -> void:
	if not firing:
		firing = true
		var targetArr: Array = targetingComponent.getTargetArr()

		if !targetArr.is_empty():
			shootingComponent.fireProjectile(targetArr)
			fireTimer.start()
		else:
			fireTimer.stop()
			firing = false


# attempt to fire every time an entity enters the targeting area
func onTargetAreaEntered() -> void:
	if fireTimer.is_stopped():
		fire()


func onFireTimerTimeout() -> void:
	firing = false
	fire()


func addMod(modItem: ModItem) -> void:
	modsComponent.addMod(modItem)


func removeMod(modItem: ModItem) -> void:
	modsComponent.removeMod(modItem)


func getMods() -> Array:
	return modsComponent.getMods()


func _on_reset_upgrades_button_pressed():
	upgrades = []


func _on_add_speed_pressed():
	upgrades.append(SpeedStrategy.new())


func _on_add_damage_pressed():
	upgrades.append(DamageStrategy.new())

func setFireDelay(value: float) -> void:
	fireDelaySeconds = value
	fireTimer.wait_time = fireDelaySeconds
