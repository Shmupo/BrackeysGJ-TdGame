class_name Tower
extends Node

@onready var targetingComponent: TargetingComponent = $TargetingComponent
@onready var shootingComponent: ShootingComponent = $ShootingComponent
# if this timer is counting, do not fire
@onready var fireTimer: Timer = $FireTimer

# fires after this amount of time has passed
@export var fireDelaySeconds: float = 0.5
var firing: bool = false

# array of projectile upgrades to be applied
var upgrades: Array[BaseProjectileStrategy] = []

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

func _on_reset_upgrades_button_pressed():
	upgrades = []


func _on_add_speed_pressed():
	upgrades.append(SpeedStrategy.new())


func _on_add_damage_pressed():
	upgrades.append(DamageStrategy.new())
