class_name PathingComponent
extends Node

## PathingComponent is used to generate a path from a spawn point to a goal
##
## Uses A* search algorithm to find the shortest valid path between the start coord and end coord
## Before calling getPath, make sure startCoord and endCoord are set:
##
## Simply call updatePath to update the variable 'path' if needed 
## Read variable 'path' to get the shortest path between start and end
##
## The aStarGrid is initialized as a completely solid grid that is the same size as the rect defined in inputComponent
## A solid tile in the aStarGrid means it cannot be traversed

var aStarGrid: AStarGrid2D = AStarGrid2D.new()

var startCoord: Vector2i
var endCoord: Vector2i
var path: PackedVector2Array

@onready var tileMapLayer: TileMapLayer = $".."
# retrieve grid sizing
@onready var inputComponent: InputComponent = $"../InputComponent"
# placing and removing paths will update the aStarGrid
@onready var tilePlacementComponent: TilePlacementComponent = $"../TilePlacementComponent"

func _ready() -> void:
	# set cell size of aStarGrid - this should not change so only need to set once
	aStarGrid.cell_size = Vector2(tileMapLayer.rendering_quadrant_size, tileMapLayer.rendering_quadrant_size)
	
	tilePlacementComponent.pathPlaced.connect(placePath)
	tilePlacementComponent.pathRemoved.connect(removePath)


func setup(newStartCoord: Vector2i, newEndCoord: Vector2i) -> void:
	startCoord = newStartCoord
	endCoord = newEndCoord
	
	initAStarGrid()


# need to call everytime a new path is made
func initAStarGrid() -> void:
	var rectPosition: Vector2i = Vector2i(-inputComponent.sizeX / 2, -inputComponent.sizeY / 2)
	var rectSize: Vector2i = Vector2i(inputComponent.sizeX, inputComponent.sizeY)
	aStarGrid.region = Rect2i(rectPosition, rectSize)
	aStarGrid.update()
	
	# error checking
	# this will print an error if it is impossible to path between startCoord and endCoord
	if aStarGrid.get_point_path(startCoord, endCoord) == null:
		print("ERROR, impossible pathing between ", startCoord, " and ", endCoord)
	
	aStarGrid.fill_solid_region(aStarGrid.region)
	
	# set start and end tiles as not solid
	aStarGrid.set_point_solid(startCoord, false)
	aStarGrid.set_point_solid(endCoord, false)
	
	# disable diagonal movement
	aStarGrid.diagonal_mode =AStarGrid2D.DIAGONAL_MODE_NEVER
	#print(aStarGrid.region)


# sets coordinate as not solid
func placePath(coord: Vector2i) -> void:
	aStarGrid.set_point_solid(coord, false)
	#print(coord, " is now not solid")
	updatePath()


# sets coordinate as solid
func removePath(coord: Vector2i) -> void:
	aStarGrid.set_point_solid(coord, true)
	updatePath()


# updates variable 'path' to the shortest path between startCoord and endCoord as an array of LOCAL coordinates
# will set path to null if no path found
func updatePath() -> void:
	if startCoord != null && endCoord != null:
		path = aStarGrid.get_point_path(startCoord, endCoord)
	else:
		print("Error, cannot generate path between ", startCoord, " and ", endCoord)


func getPath() -> PackedVector2Array:
	return path
