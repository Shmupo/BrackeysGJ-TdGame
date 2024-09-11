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
}

# exposed here so you don't have to access the movementComponent
# passed the value to the movement component automatically
@export var moveSpeed: float = 10 : set = setMoveSpeed


func _ready() -> void:
	configure(config)  # Apply the default config


# sets the path for the entity to follow
# places entity at start of path
func setup(path: PackedVector2Array) -> void:
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
	config = new_config
	
	if config.has("speed"):
		moveSpeed = config["speed"]
		setMoveSpeed(moveSpeed)
	
	# TODO: update other internal variables


# pass into movement component
func setMoveSpeed(value: float) -> void:
	movementComponent.setMoveSpeed(value)


func startMoving() -> void:
	movementComponent.startMoving()
