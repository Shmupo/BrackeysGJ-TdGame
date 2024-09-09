class_name TilePlacementComponent
extends Node2D

## TilePlacementComponent is to be a child of a TileMapLayer
##
## This script handles how the user places tiles to create paths
##
## The bounds that define what tile the user can click on is taken from the InputComponent

# emits whenever user places or removes a path tile
signal pathPlaced(coord: Vector2i)
signal pathRemoved(coord: Vector2i)

var tileMapLayer: TileMapLayer
var inputComponent: InputComponent

# the source id of the tileset to search in
var tileSourceId: int = 0
# the tile texture chosen to place as a path tile
var pathAtlasCoord: Vector2i = Vector2i(9, 0)

# coordinates the user cannot place paths on
var invalidCoords: Array[Vector2i]


func _ready() -> void:
	inputComponent = $"../InputComponent"
	tileMapLayer = get_parent()
	
	inputComponent.userClickTile.connect(onTileButtonClicked)


#func _input(event: InputEvent) -> void:
	## "event is InputEventMouseButton" prevents counting a single physical click as two and causing bugs
	#if Input.is_action_just_released("LeftMouseClick") and event is InputEventMouseButton:
		## grid coordinate of mouse on the tilemap
		#var gridMouseCoord: Vector2i = tileMapLayer.local_to_map(get_local_mouse_position())
		#
		#if !gridMouseCoord in invalidCoords: # if within bounds defined within inputComponent
			##print("Clicked on tile: ", gridMouseCoord)
			#if inputComponent.tileButtonsDict.has(gridMouseCoord):
				#if tileMapLayer.get_cell_tile_data(gridMouseCoord) == null: # if there is no tile here
					##print("Clicked on an empty path - placing path...")
					#placePathOnMap(gridMouseCoord)
				#else: # if there is a tile here
					##print("Clicked on a path - removing path...")
					#removePath(gridMouseCoord)
			##else:
				##print("Clicked on a tile outside bounds - no changes made...")
		##else:
			##print("Clicked on an invalid coord - no changes made...")

# uses the buttons generated by InputComponent to handle user input
func onTileButtonClicked(coord: Vector2i) -> void:
	if coord not in invalidCoords:
		if tileMapLayer.get_cell_tile_data(coord) == null: # if tile is empty
			placePathOnMap(coord)
		else:
			removePath(coord)
	else:
		print("Clicked on an invalid coord - no changes made...")

# places a path tile at the grid coordinate
func placePathOnMap(coord: Vector2i) -> void:
	tileMapLayer.set_cell(coord, tileSourceId, pathAtlasCoord)
	pathPlaced.emit(coord)


# removes path at coordinate
func removePath(coord: Vector2i) -> void:
	# setting source_id to -1 will make this an empty cell
	tileMapLayer.set_cell(coord, -1)
	pathRemoved.emit(coord)
