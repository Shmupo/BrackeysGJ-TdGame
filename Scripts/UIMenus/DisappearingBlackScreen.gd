extends ColorRect

# Exported variables to adjust transparency speed and initial visibility
@export var fade_duration: float = 2.0  # Time in seconds to fully fade out
@export var initial_visibility: bool = true

# Internal variables
var _fade_timer: float = 0.0

func _ready() -> void:
	visible = initial_visibility
	modulate.a = 1.0

# Called every frame
func _process(delta: float) -> void:
	if modulate.a > 0:
		_fade_timer += delta
		modulate.a = max(0.0, 1.0 - _fade_timer / fade_duration)

		if modulate.a == 0:
			queue_free()
