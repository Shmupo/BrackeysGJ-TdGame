extends Node

## TowerSpawner creates empty base towers randomly along the path
##
## This is how the user gets more towers

# add towers as children to this
@onready var towersParent: Node2D = $"../Towers"

var userInteractableTileMapLayer: UserInteractableTilemapLayer
var pathingComponent: PathingComponent
var tilePlacementComponent: TilePlacementComponent
var backgroundLayer: TileMapLayer

var neighbor_values: Array = [
	TileSet.CELL_NEIGHBOR_TOP_LEFT_SIDE,
	TileSet.CELL_NEIGHBOR_TOP_SIDE,
	TileSet.CELL_NEIGHBOR_TOP_RIGHT_SIDE,
	TileSet.CELL_NEIGHBOR_LEFT_SIDE,
	TileSet.CELL_NEIGHBOR_RIGHT_SIDE,
	TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE,
	TileSet.CELL_NEIGHBOR_BOTTOM_SIDE,
	TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE
]

var baseTowerScene: PackedScene = load("res://Scenes/Components/Tower/TestTower1.tscn")
var towerScale: Vector2 = Vector2(2, 2)

func _ready() -> void:
	userInteractableTileMapLayer = get_tree().get_first_node_in_group("UserInteractableTileMapLayer")
	pathingComponent = userInteractableTileMapLayer.pathingComponent
	backgroundLayer = get_tree().get_first_node_in_group("BackgroundLayer")
	userInteractableTileMapLayer = get_tree().get_first_node_in_group("UserInteractableTileMapLayer")
	tilePlacementComponent = get_tree().get_first_node_in_group("TilePlacementComponent")
	
	add_to_group("TowerSpawner")

# call this to spawn one tower randomly on the map
func spawnTower() -> void:
	var tower: Tower = baseTowerScene.instantiate()
	towersParent.add_child(tower)
	
	# get a random valid coordinate
	var tile: Vector2i = backgroundLayer.get_used_cells().pick_random()
	while !isCoordValid(tile):
		tile = backgroundLayer.get_used_cells().pick_random()

	tower.towerDragComponent.placeAtTile(tile)
	tower.scale = towerScale


func isCoordValid(coord: Vector2i) -> bool:
	var isNotPathTile: bool = userInteractableTileMapLayer.get_cell_tile_data(coord) == null
	var isInvalidCoord: bool = coord not in tilePlacementComponent.invalidCoords
	var isBackgroundTile: bool = backgroundLayer.get_cell_tile_data(coord) != null
	return isNotPathTile and isInvalidCoord and isBackgroundTile


# get grid map coordinate of a random path tile
func getRandomPathTileCoord() -> Vector2i:
	return userInteractableTileMapLayer.local_to_map(userInteractableTileMapLayer.to_local(pathingComponent.path.pick_random()))


func _on_add_tower_button_button_up() -> void:
	spawnTower()
