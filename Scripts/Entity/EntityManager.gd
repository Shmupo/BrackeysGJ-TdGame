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

# TESTING
@onready var spawnEntityButton: Button = $"../../SpawnEntityButton"

@onready var knightEntity: PackedScene = preload("../../Scenes/Components/Entities/KnightEntity.tscn")

var startCoord: Vector2

# keep count of alive entities
# increment when spawn entity
# decrement when deleting entity
var entitiesCount: int = 0

func _ready() -> void:
	spawnEntityButton.button_up.connect(spawnAndSendOutEntity)

# make sure the the path is valid and generated before calling this
func getPath() -> PackedVector2Array:
	return userInteractableTileMapLayer.pathingComponent.getPath()

func spawnAndSendOutEntity() -> void:
	entitiesCount += 1
	var testEntityInstance: Entity = knightEntity.instantiate()
	# NOTE - need to add to scene first to allow certain variables to initialize
	add_child(testEntityInstance)
	testEntityInstance.setup(getPath())
	testEntityInstance.startMoving()
