class_name TileMapButton
extends TextureButton

# emits the grid position that the user clicks on
signal userButtonUpCell(cellPostions: Vector2i)

var cellPosition: Vector2i

func _ready() -> void:
	button_up.connect(onPressed)
	
func onPressed() -> void:
	userButtonUpCell.emit(cellPosition)
	# DEBUG - pring coordinate that was clicked	
	# print(cellPosition)
