extends ColorRect

func _ready() -> void:
	show()
	color.a = 0

# Called every frame
func _process(delta: float) -> void:
	if color.a < 0.8:
		color.a += delta 
