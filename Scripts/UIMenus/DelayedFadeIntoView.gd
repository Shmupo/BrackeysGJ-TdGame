extends Container

# Time it takes to fade in (in seconds)
@export var fade_duration: float = 2.0

# Current alpha value (starts at 0, fully transparent)
var current_alpha: float = 0.0

# Boolean to control the fade in process
var is_fading: bool = true

func _ready():
	# Set initial transparency to 0 (fully transparent)
	modulate.a = 0.0
	# Start the fade-in process
	is_fading = true
	set_process(true)

func _process(delta: float):
	if is_fading:
		# Increase alpha over time
		current_alpha += delta / fade_duration
		# Clamp alpha to 1.0 (fully visible)
		current_alpha = clamp(current_alpha, 0.0, 1.0)
		# Apply the new alpha to the node
		modulate.a = current_alpha

		# Stop fading when fully visible
		if current_alpha >= 1.0:
			is_fading = false
			set_process(false)
