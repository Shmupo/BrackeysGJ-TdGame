class_name HealthBar
extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause()
	set_frame_and_progress(0, 0)


## Set health percentage as a float value between 0 and 1
func set_health_percent(percent: float) -> void:
	var n_frames = 9
	var frame = floor((1.0 - percent) * 9)
	set_frame_and_progress(frame, 0)
	
