extends Node2D

## TilePlacementComponent is to be a child of a TileMapLayer
##
## This script handles how the user places tiles to create paths
##
## The bounds that define what tile the user can click on is taken from the InputComponent

var tileMapLayer: TileMapLayer
var inputComponent: InputComponent

# the source id of the tileset to search in
var tileSourceId: int = 0
# the tile texture chosen to place as a path tile
var pathAtlasCoord: Vector2i = Vector2i(9, 0)

func _ready() -> void:
	inputComponent = $"../InputComponent"
	tileMapLayer = get_parent()

func _input(event: InputEvent) -> void:
	# "event is InputEventMouseButton" prevents counting a single physical click as two and causing bugs
	if Input.is_action_just_released("LeftMouseClick") and event is InputEventMouseButton:
		var localMousePos: Vector2 = get_local_mouse_position()
		var gridMouseCoord: Vector2i = tileMapLayer.local_to_map(localMousePos)
		# do if user clicks on a tile that is within bounds
		if inputComponent.tileButtonsDict.has(gridMouseCoord):
			print("Clicked on tile: ", gridMouseCoord)
			if tileMapLayer.get_cell_tile_data(gridMouseCoord) == null:
				print("Clicked on an empty path - placing path...")
				placePathOnMap(gridMouseCoord)
			else:
				print("Clicked on a path - removing path...")
				removePath(gridMouseCoord)
		else:
			print("Clicked on a tile outside the bounds: ", gridMouseCoord)
				

# places a path tile at the grid coordinate
func placePathOnMap(coord: Vector2i) -> void:
	tileMapLayer.set_cell(coord, tileSourceId, pathAtlasCoord)

# removes path at coordinate
func removePath(coord: Vector2i) -> void:
	# setting source_id to -1 will make this an empty cell
	tileMapLayer.set_cell(coord, -1)
