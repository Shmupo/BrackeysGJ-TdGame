class_name InputComponent
extends Node2D

## InputComponent is to be a child of a TileMapLayer
##
## Instead of trying to handle inputs ourselves, use input components Godot already provides: buttons
##
## This script generates an array of invisible buttons on top of the tilemap
## To get the grid coordinate of the clicked tile, connect to the userClickTile signal from an external script
##
## The buttons generated are to be used as UI indicators, such as highlighting or hovering over tiles
## This DOES NOT handle tile placement
## TODO : add hover and select textures?

signal userClickTile(coord: Vector2i)

var tileMapLayer: TileMapLayer
# use this for getting the button at the grid coordinate
# { Vector2i Grid Coordinate : Texture Button }
var tileButtonsDict: Dictionary

# size dimensions of the user-interactable area
var sizeX: int
var sizeY: int

func _ready() -> void:
	tileMapLayer = get_parent()
	
	generateTilemapButtons()
	
func setup(newGridSizeX: int, newGridSizeY: int) -> void:
	sizeX = newGridSizeX
	sizeY = newGridSizeY
	
	generateTilemapButtons()
	
# generates the tile buttons for tile selection
func generateTilemapButtons() -> void:
	# getting the local coords and grid coords 
	# local coords are used to place the buttons on top of the tilemap
	# grid coords are used to store the tilemap grid coordinate of the button
	var cellCoords: Array[Vector2i]
	var localCoords: Array[Vector2]
	
	for x in range(-sizeX/2 , sizeX/2):
		for y in range(-sizeY/2, sizeY/2):
			cellCoords.append(Vector2i(x, y))
	
	for coord in cellCoords:
		var localCoord: Vector2 = tileMapLayer.map_to_local(coord)
		localCoords.append(localCoord)
	
	var cellSizeOffset: int = tileMapLayer.rendering_quadrant_size / 2
	
	# for each coord, generate a button
	for coordIdx in range(cellCoords.size()):
		var newButton: TileMapButton = createButton()
		# add button as child of this input component
		add_child(newButton)
		# place button correctly over correct grid square and set grid position data
		newButton.position = localCoords[coordIdx] - Vector2(cellSizeOffset, cellSizeOffset)
		newButton.cellPosition = cellCoords[coordIdx]
		newButton.userButtonUpCell.connect(onTileClicked)
		
		# adding to coord : button dictionary
		tileButtonsDict[cellCoords[coordIdx]] = newButton

# generate a TileMapButton instance with the correct tile size
func createButton() -> TileMapButton:
	var newButton: TileMapButton = TileMapButton.new()
	#DEBUG - use this to see the buttons individually
	#newButton.texture_normal = load("res://Assets/Resources/Green1Tile.tres")
	var cellSize: int = tileMapLayer.rendering_quadrant_size
	newButton.set_size(Vector2(cellSize, cellSize))
	
	return newButton

func onTileClicked(gridCoord: Vector2i):
	userClickTile.emit(gridCoord)
	# DEBUG - print coordinate that was clicked
	#print(gridCoord)
