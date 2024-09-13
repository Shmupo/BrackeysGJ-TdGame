class_name Entity
extends Node2D

# get parent
@onready var entityManager: EntityManager = %EntityManager
@onready var movementComponent: MovementComponent = $MovementComponent

# Dictionary is used for initial configuration
# This allows the same interface for all subclasses, even with varying config
@export var config: Dictionary = {
	"speed": 10,
	"health": 10,
	"armor": 0
} : set = configure

# exposed here so you don't have to access the movementComponent
# passed the value to the movement component automatically
@export var moveSpeed: float = 10: set = setMoveSpeed

@export var health: float = 5


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
		health = config["health"]
	
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
	movementComponent.queue_free()
	queue_free()

func removeHealth(amount: float) -> void:	
	health -= amount
	if health <= 0:
		die()
