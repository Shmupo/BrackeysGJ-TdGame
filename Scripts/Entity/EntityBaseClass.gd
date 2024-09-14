class_name Entity
extends Node2D

# get parent
@onready var entity_manager: EntityManager = %EntityManager
@onready var movementComponent: MovementComponent = $MovementComponent
@onready var health_bar: HealthBar = $HealthBar

@onready var player: Player = %Player



# Dictionary is used for initial configuration
# This allows the same interface for all subclasses, even with varying config
@export var config: Dictionary = {
	"speed": 10,
	"health": 10,
	"armor": 0,
	"points": 100,
	"damage": 10
} : set = configure

# exposed here so you don't have to access the movementComponent
# passed the value to the movement component automatically
@export var moveSpeed: float = 10: set = setMoveSpeed
@export var points_value: int = 100
@export var max_health: float = 5.0
@onready var health = self.max_health



func _ready() -> void:
	configure(config)  # Apply the default config


# sets the path for the entity to follow
# places entity at start of path
func setup(path: PackedVector2Array) -> void:
	setMoveSpeed(moveSpeed)
	
	if path.size() > 0:
		movementComponent.setup(path)
		global_position = path[0]
	else: # no path set, delete self
		queue_free()


## Allow for easy configuration of the entity
##
## Accepts a dictionary with key value pairs to configure the entity.
## Use this method to apply the configuration the entity will have on spawn.
func configure(new_config: Dictionary) -> void:
	if config != new_config:
		config = new_config
		
	if config.has("speed"):
		moveSpeed = config["speed"]
		#setMoveSpeed(config["speed"])
		
	if config.has("health"):
		max_health = config["health"]
		health = config["health"]
	
	if config.has("points"):
		points_value = config["points"]
	
	# TODO: update other internal variables


# pass into movement component
func setMoveSpeed(value: float) -> void:
	if movementComponent == null:
		return
	
	movementComponent.setMoveSpeed(value)


func startMoving() -> void:
	movementComponent.startMoving()


# perhaps particles, death sound, score, whatever
# always good to have as seperate function
func die() -> void:
	if player == null:
		player = get_parent().get_node("%Player")  # No clue why parent is needed here
	if player != null:
		player.add_points(points_value)
		
	movementComponent.queue_free()
	queue_free()


func removeHealth(amount: float) -> void:	
	health -= amount
	health_bar.set_health_percent(health / max_health)
	if health <= 0:
		die()
