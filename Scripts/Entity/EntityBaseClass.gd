class_name Entity
extends Node2D

# get parent
@onready var entityManager: EntityManager = $"."

@onready var movementComponent: MovementComponent

# exposed here so you don't have to access the movementComponent
# passed the value to the movement component automatically
@export var moveSpeed: float = 10 : set = setMoveSpeed

# do this before allowing this entity to do stuff
func setup(path: PackedVector2Array) -> void:
	movementComponent.setup(path)

# pass into movement component
func setMoveSpeed(value: float) -> void:
	movementComponent.setMoveSpeed(value)
