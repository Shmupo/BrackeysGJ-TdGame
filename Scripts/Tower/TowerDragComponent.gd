class_name TowerDragComponent
extends Node2D

@onready var tower: Tower = $".."
@onready var dragButton: Button = $"../TowerMenuButton"

var userInteractableTileMapLayer: UserInteractableTilemapLayer
var tilePlacementComponent: TilePlacementComponent

var dragging: bool = false

# this is a modified version of the DragComponent script, which is used for modItems
# NOTE: The tower will snap to the grid coordinates according to the tilemap of the background layer

func _ready() -> void:
	dragButton.button_up.connect(onReleaseFromDrag)
	
	userInteractableTileMapLayer = get_tree().get_first_node_in_group("UserInteractableTileMapLayer")
	tilePlacementComponent = get_tree().get_first_node_in_group("TilePlacementComponent")


func setDrag() -> void:
	dragging = true
	var globalMousePos: Vector2 = get_global_mouse_position()
	var mouseCoord: Vector2 = getMouseTileGlobalPosition()
	var tilePosition: Vector2 = getMouseTileGlobalPosition()
	if tilePosition != Vector2(-999, -999):
		tower.global_position = mouseCoord
		
	dragButton.disableTowerMenu()


# returns the global position of the mouse
# returns Vector2(-999, -999) if the mouse is not in a valid tile
func getMouseTileGlobalPosition() -> Vector2:
	var globalMousePos: Vector2 = get_global_mouse_position()
	var tileCoord: Vector2i = userInteractableTileMapLayer.local_to_map(userInteractableTileMapLayer.to_local(globalMousePos))
	return userInteractableTileMapLayer.to_global(userInteractableTileMapLayer.map_to_local(tileCoord))
	

# try to snap to a modSlot if close enough
func onReleaseFromDrag() -> void:
	if dragging:
		dragging = false
		dragButton.enableTowerMenu()


# returns true if the grid coordinate is a path tile or an invalid tile
func isCoordPathOrInvalid(coord: Vector2i) -> bool:
	return userInteractableTileMapLayer.get_cell_tile_data(coord) == null or coord in tilePlacementComponent.invalidCoords


func _process(delta: float) -> void:
	if dragging:
		var mouseCoord: Vector2 = getMouseTileGlobalPosition()
		var tilePosition: Vector2 = getMouseTileGlobalPosition()
		if tilePosition != Vector2(-999, -999):
			tower.global_position = mouseCoord
