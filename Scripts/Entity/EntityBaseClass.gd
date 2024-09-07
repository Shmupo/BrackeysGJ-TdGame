class_name Entity
extends Node2D

# get parent
@onready var entityManager: EntityManager = $".."

@onready var movementComponent: MovementComponent = $MovementComponent

# exposed here so you don't have to access the movementComponent
# passed the value to the movement component automatically
@export var moveSpeed: float = 10 : set = setMoveSpeed

# sets the path for the entity to follow
# places entity at start of path
func setup(path: PackedVector2Array) -> void:
	if path.size() > 0:
		movementComponent.setup(path)
		position = path[0]
	else:
		print("Error: trying to set a path with no values onto entity, calling queue free onto entity")
		# delete this entity since no path will be followed
		queue_free()

# pass into movement component
func setMoveSpeed(value: float) -> void:
	movementComponent.setMoveSpeed(value)

func startMoving() -> void:
	movementComponent.startMoving()
