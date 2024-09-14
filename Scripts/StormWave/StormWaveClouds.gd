extends Node2D

var vel: float = 0.3  # Speed of the movement
var amplitude: float = 20  # How far it moves left and right
var start_position: Vector2  # The starting position of the cloud
var time_passed: float = 0  # Time tracker for smooth movement

# calls lightning every 15 seconds
@onready var lightningTimer: Timer = $LightningTimer

var yOffset: float = 100

func _ready() -> void:
	start_position = position  # Save the initial position
	lightningTimer.timeout.connect(triggerLightning)

func triggerLightning() -> void:
	var randomTower: Node2D = get_tree().get_first_node_in_group("Towers").get_children().pick_random()
	
	if randomTower == null:  # If there are no more towers
		return 
	
	var lightning = Line2D.new()  # Create a new Line2D node
	lightning.width = 10  # Set the width of the line
	lightning.default_color = Color(1, 1, 0)  # Set color to yellow
	
	# Generate points for a jagged lightning effect
	var points = generate_lightning_points(Vector2(randomTower.global_position.x, -10), randomTower.global_position)
	
	# Set the points for the Line2D
	for point in points:
		lightning.add_point(point)
	
	add_child(lightning)  # Add the lightning to the scene

	randomTower.queue_free()

	# Remove the lightning after a short time
	await get_tree().create_timer(0.3).timeout  # Wait for 0.3 seconds
	lightning.queue_free()  # Remove the lightning after the effect

func generate_lightning_points(start: Vector2, end: Vector2) -> Array:
	var points = []
	points.append(start)

	var num_segments = 15  # Number of segments for the lightning
	var direction = (end - start).normalized()  # Normalize the direction vector
	var distance = start.distance_to(end)
	var segment_length = distance / num_segments  # Length of each segment
	
	for i in range(1, num_segments):
		var last_point = points[i - 1]

		# Generate a random displacement for jagged effect
		var displacement = Vector2(randf_range(-30, 30), randf_range(-30, 30))

		# Calculate the next point position
		var next_point = last_point + direction * segment_length + displacement
		points.append(next_point)

	# Ensure the lightning reaches the target position
	points.append(end)
	return points

func _process(delta: float) -> void:
	time_passed += delta  # Update the time passed
	position.x = start_position.x + sin(time_passed * vel) * amplitude
	
	if yOffset != 0:
		position.y += 1
		yOffset -= 1
