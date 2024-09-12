class_name TowerDragComponent
extends Node2D

@onready var tower: Tower = $".."
@onready var dragButton: Button = $"../TowerMenuButton"

var backgroundLayer: TileMapLayer
var userInteractableTileMapLayer: UserInteractableTilemapLayer
var tilePlacementComponent: TilePlacementComponent

var dragging: bool = false

## The TowerDragComponent allows the user to move the tower when pressing the "Move" button in the TowerMenu
##
## The tower can only be placed on valid tiles: tiles that are not path tiles ...
## ... and tiles that are not in the invalid tiles array (ex. startTile, endTile)
##
## After clicking on move, click on the tower again to place the tower
##
## This script is a modified DragComponent of ModItems
## NOTE: The tower will snap to the grid coordinates according to the tilemap of the userInteractableTileMapLayer
## The userInteractableTileMapLayer is to get the path tiles
## The tilePlacementComponent is to get the invalid tiles
## The backgroundLayer defines the area in which the tower can be placed

func _ready() -> void:
	dragButton.button_up.connect(onReleaseFromDrag)
	
	backgroundLayer = get_tree().get_first_node_in_group("BackgroundLayer")
	userInteractableTileMapLayer = get_tree().get_first_node_in_group("UserInteractableTileMapLayer")
	tilePlacementComponent = get_tree().get_first_node_in_group("TilePlacementComponent")


# attaches the tower to the mouse position
func setDrag() -> void:
	dragging = true
	var mouseCoord: Vector2i = getMouseTileCoord()
	setTileValid(getTowerCoord())
	if isCoordValid(mouseCoord):
		tower.global_position = getMouseTileGlobalPosition()
		
	dragButton.disableTowerMenu()


# returns the global position of the grid coordinate that the mouse is on top of
func getMouseTileGlobalPosition() -> Vector2:
	return userInteractableTileMapLayer.to_global(userInteractableTileMapLayer.map_to_local(getMouseTileCoord()))
	

# returns the grid coordinate in the tilemap that the mouse is on top of
func getMouseTileCoord() -> Vector2i:
	return userInteractableTileMapLayer.local_to_map(userInteractableTileMapLayer.to_local(get_global_mouse_position()))


# returns the current grid coordinate of the tower
func getTowerCoord() -> Vector2i:
	return userInteractableTileMapLayer.local_to_map(userInteractableTileMapLayer.to_local(tower.global_position))


# try to snap to a modSlot if close enough
func onReleaseFromDrag() -> void:
	if dragging:
		dragging = false
		dragButton.enableTowerMenu()
		setTileInvalid(getTowerCoord())


# adds coord to the invalid coords
func setTileInvalid(coord: Vector2i) -> void:
	tilePlacementComponent.invalidCoords.append(coord)


# removes the coord from invalid coords
func setTileValid(coord: Vector2i) -> void:
	var foundIdx: int = tilePlacementComponent.invalidCoords.find(coord)
	if foundIdx != -1:
		tilePlacementComponent.invalidCoords.remove_at(foundIdx)


# returns true if the grid coordinate is a path tile or an invalid tile
func isCoordValid(coord: Vector2i) -> bool:
	var isNotPathTile: bool = userInteractableTileMapLayer.get_cell_tile_data(coord) == null
	var isInvalidCoord: bool = coord not in tilePlacementComponent.invalidCoords
	var isBackgroundTile: bool = backgroundLayer.get_cell_tile_data(coord) != null
	return isNotPathTile and isInvalidCoord and isBackgroundTile


# instantly places the tower onto this tile
# also handles tile validity
func placeAtTile(coord: Vector2i) -> void:
	if isCoordValid(coord):
		setTileValid(userInteractableTileMapLayer.local_to_map(userInteractableTileMapLayer.to_local(tower.global_position)))
		tower.global_position = userInteractableTileMapLayer.to_global(userInteractableTileMapLayer.map_to_local(coord))
		setTileInvalid(coord)


func _process(delta: float) -> void:
	if dragging:
		var mouseCoord: Vector2i = getMouseTileCoord()
		if isCoordValid(mouseCoord):
			tower.global_position = getMouseTileGlobalPosition()
