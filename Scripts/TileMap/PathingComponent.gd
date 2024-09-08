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

# Godot's engine-provided search algorithm optimized for tileMapLayer
var aStarGrid: AStarGrid2D = AStarGrid2D.new()

# start of path
var startCoord: Vector2i
# end of path
var endCoord: Vector2i

# array of global grid coordinates represent each grid square on the path
var path: Array[Vector2]

# used to offest onto the center of the grid square
var halfTileSize: Vector2

# parent
@onready var tileMapLayer: UserInteractableTilemapLayer = $".."

# placing and removing paths will update the aStarGrid
@onready var tilePlacementComponent: TilePlacementComponent = $"../TilePlacementComponent"

func _ready() -> void:
	# set cell size of aStarGrid - this should not change so only need to set once
	var cellSize: Vector2 = Vector2(tileMapLayer.rendering_quadrant_size, tileMapLayer.rendering_quadrant_size)
	aStarGrid.cell_size = cellSize
	halfTileSize = (cellSize / 2) * tileMapLayer.scale
	
	tilePlacementComponent.pathPlaced.connect(placePath)
	tilePlacementComponent.pathRemoved.connect(removePath)


func setup(newStartCoord: Vector2i, newEndCoord: Vector2i) -> void:
	startCoord = newStartCoord
	endCoord = newEndCoord
	
	initAStarGrid()


# need to call everytime a new path is made
func initAStarGrid() -> void:
	var rectPosition: Vector2i = Vector2i(-tileMapLayer.gridSizeX / 2, -tileMapLayer.gridSizeY / 2)
	var rectSize: Vector2i = Vector2i(tileMapLayer.gridSizeX, tileMapLayer.gridSizeY)
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
# updates the path every time this is called
func placePath(coord: Vector2i) -> void:
	aStarGrid.set_point_solid(coord, false)
	#print(coord, " is now not solid")
	updatePath()


# sets coordinate as solid
# updates the path every time this is called
func removePath(coord: Vector2i) -> void:
	aStarGrid.set_point_solid(coord, true)
	updatePath()


# updates variable 'path' to the shortest path between startCoord and endCoord as an array of LOCAL coordinates
# will set path to null if no path found
func updatePath() -> void:
	if startCoord != null && endCoord != null:
		# get_point_path only returns local coordinates
		var localPath: PackedVector2Array = aStarGrid.get_point_path(startCoord, endCoord)
		path.clear()

		# convert local coordinates to global coordinates
		# also need to add tile size offset because the coordinates currently are positions at the top left corner of the grid square
		if localPath.size() > 0:
			for localCoord in localPath:
				path.append(tileMapLayer.to_global(localCoord) + halfTileSize)
				
		print(path)
	else:
		print("Error, cannot generate path between ", startCoord, " and ", endCoord)


func getPath() -> Array[Vector2]:
	return path
