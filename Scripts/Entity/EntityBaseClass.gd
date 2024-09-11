class_name Entity
extends Node2D

# get parent
@onready var entityManager: EntityManager = %EntityManager

@onready var movementComponent: MovementComponent = $MovementComponent

# exposed here so you don't have to access the movementComponent
# passed the value to the movement component automatically
@export var moveSpeed: float = 10 : set = setMoveSpeed

# sets the path for the entity to follow
# places entity at start of path
func setup(path: PackedVector2Array) -> void:
	if path.size() > 0:
		movementComponent.setup(path)
		global_position = path[0]
	else: # no path set, delete self
		queue_free()

# pass into movement component
func setMoveSpeed(value: float) -> void:
	movementComponent.setMoveSpeed(value)

func startMoving() -> void:
	movementComponent.startMoving()
