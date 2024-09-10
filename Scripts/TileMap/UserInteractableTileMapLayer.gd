class_name UserInteractableTilemapLayer
extends TileMapLayer

## The UserInteractableTileMapLayer is the layer in which the user can click on tiles to generate a path for enemies to follow
## 
##
## All tiles place within this TileMapLayer are used for pathing
## Therfore, do NOT place any tiles that are NOT going to be used to path
##
## The user can add or remove paths
## The user can add or remove turrets
##
## This script is used simply for developer information, no code is placed here for now...

# define the square grid size that the user can interact with
@export var gridSizeX: int = 12
@export var gridSizeY: int = 12

# set position of start and end
@export var startTile: Vector2i = Vector2i(3, 3) # placeholder
@export var endTile: Vector2i = Vector2i(-3, -3) # placeholder

@onready var inputComponent: InputComponent = $InputComponent
@onready var tilePlacementComponent: TilePlacementComponent = $TilePlacementComponent
@onready var pathingComponent: PathingComponent = $PathingComponent

func _ready() -> void:
	if gridSizeX % 2 != 0:
		print("WARNING: gridSizeX should be even to avoid potential bugs")
	if gridSizeY % 2 != 0:
		print("WARNING: gridSizeY should be even to avoid potential bugs")

	setStartAndEndTiles()

	# set initial values to proc generation
	inputComponent.setup(gridSizeX, gridSizeY)
	pathingComponent.setup(startTile, endTile)

func setStartAndEndTiles() -> void:
	var tileSource: int = 1
	var startTileAtlas: Vector2i = Vector2i(0, 0)
	var endTileAtlas: Vector2i = Vector2i(1, 0)

	set_cell(startTile, tileSource, startTileAtlas)
	set_cell(endTile, tileSource, endTileAtlas)

	# adds start and end tile to invalid tiles in tilePlacementComponent 
	# so that the user cannot draw a path on top of these
	tilePlacementComponent.invalidCoords.append_array([startTile, endTile])
