class_name Entity
extends Node2D

# get parent
@onready var entityManager: EntityManager = $".."

@onready var movementComponent: MovementComponent = $MovementComponent

# exposed here so you don't have to access the movementComponent
# passed the value to the movement component automatically
@export var moveSpeed: float = 10

@export var health: float = 5

# sets the path for the entity to follow
# places entity at start of path
func setup(path: PackedVector2Array) -> void:
	setMoveSpeed(moveSpeed)
	
	if path.size() > 0:
		movementComponent.setup(path)
		global_position = path[0]
	else: # no path set, delete self
		queue_free()

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
	queue_free()

func removeHealth(amount: float) -> void:	
	health -= amount
	if health <= 0:
		die()
