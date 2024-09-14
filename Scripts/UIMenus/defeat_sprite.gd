class_name DefeatSprite
extends AnimatedSprite2D


func start_animation() -> void:
	set_frame_and_progress(0, 0)
	play()

func _on_frame_changed() ->  void:
	if frame == 8:
		pause()
