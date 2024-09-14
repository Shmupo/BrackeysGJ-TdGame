class_name Entity
extends Node2D

signal died

@onready var entityManager: EntityManager = $".."
@onready var movementComponent: MovementComponent = $MovementComponent
@onready var sprite: Sprite2D = $EntitySprite2D

var player: Player

# Dictionary is used for initial configuration
# This allows the same interface for all subclasses, even with varying config
@export var config: Dictionary = {
	"speed": 10,
	"health": 1,
	"armor": 0,
	"points": 100,
	"damage": 10
} : set = configure

@export var moveSpeed: float = 10: set = setMoveSpeed
@export var points_value: int = 100
@export var max_health: float = 5.0
@export var strength: int = 10
@onready var health = self.max_health

var is_dead = false

# Flashing variables
var flashing_intensity: float = 0.0
var max_flashing_intensity: float = 1.0
var flashing_decay_rate: float = 2.0  # How quickly the flashing fades (in seconds)

func _ready() -> void:
	configure(config)
	player = get_player()


func _process(delta: float) -> void:
	# If the entity is flashing, reduce the intensity over time
	if flashing_intensity > 0:
		flashing_intensity -= flashing_decay_rate * delta
		flashing_intensity = max(flashing_intensity, 0)  # Ensure it doesn't go below 0
		
		# Modulate the sprite based on the flashing intensity (red tint)
		sprite.modulate = Color(1, 1 - flashing_intensity, 1 - flashing_intensity)  # Flash red

	# Reset sprite modulate back to white when flashing stops
	if flashing_intensity <= 0:
		sprite.modulate = Color(1, 1, 1)


# sets the path for the entity to follow
# places entity at start of path
func setup(path: PackedVector2Array) -> void:
	setMoveSpeed(moveSpeed)
	
	if path.size() > 0:
		movementComponent.setup(path)
		global_position = path[0]
	else: # no path set, delete self
		queue_free()


func configure(new_config: Dictionary) -> void:
	if config != new_config:
		config = new_config
		
	if config.has("speed"):
		moveSpeed = config["speed"]
		
	if config.has("health"):
		max_health = config["health"]
		health = config["health"]
	
	if config.has("points"):
		points_value = config["points"]
		
	if config.has("strength"):
		strength = config["strength"]


func setMoveSpeed(value: float) -> void:
	if movementComponent == null:
		return
	
	movementComponent.setMoveSpeed(value)


func startMoving() -> void:
	movementComponent.startMoving()

func get_player() -> Player:
	return get_tree().get_first_node_in_group("Player")


func die() -> void:
	is_dead = true
	player.add_points(points_value)
	delete()


func hit_base() -> void:
	player.take_damage(strength)
	delete()


func delete() -> void:
	died.emit()
	movementComponent.queue_free()
	queue_free()


# Decrease health and flash red
func removeHealth(amount: float) -> void:	
	health -= amount

	#print("Health" + health)

	# Trigger the flash effect by setting the flashing intensity to max
	flashing_intensity = max_flashing_intensity
	
	if health <= 0:
		die()
