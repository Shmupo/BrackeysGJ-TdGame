class_name EntityManager
extends Node2D

## Entity Manager is to be a child of the UserInteractableTileMapLayer
## This allows access to the path generated by the pathing component
##
## Add entities as children of this node
##
## This script is used to spawn entities and send them down the path.
## Also keeps track of entities

# set as parent
@onready var userInteractableTileMapLayer: UserInteractableTilemapLayer = $".."

# entities that are waiting to be sent onto the path
var waitingEntities: Array[Entity] = []
# entities that are currently moving down the path
var activeEntities: Array[Entity] = []

# make sure the the path is valid and generated before calling this
func getPath() -> PackedVector2Array:
	return userInteractableTileMapLayer.pathingComponent.getPath()

func createTestEntity() -> void:
	pass

func sendOutNextEntity() -> void:
	pass
