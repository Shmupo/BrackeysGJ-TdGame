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

# if this timer is counting, do not fire
@onready var fireTimer: Timer = $FireTimer

# fires after this amount of time has passed
@export var fireDelaySeconds: float = 0.5
var firing: bool = false

var towerName: String = "TestTower1"

func _ready() -> void:
	targetingComponent.areaEntered.connect(onTargetAreaEntered)
	fireTimer.wait_time = fireDelaySeconds
	fireTimer.timeout.connect(onFireTimerTimeout)

func fire() -> void:
	if not firing:
		firing = true
		var target: Node2D = targetingComponent.getTarget()
		
		if target != null:
			shootingComponent.fireProjectile(target)
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

# TODO
func getMods() -> Array:
	return []
