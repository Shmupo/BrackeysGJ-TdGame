class_name MovementComponent
extends Node

## Pathing Component moves the entity (parent node) along a PackedVector2Array
## 
## The PackedVector2Array consists of local grid positions to move along
## Make sure this is a child of an entity class node

# set true to start moving
var moving: bool = false
# ref to tilemap path
# this should be an array of Vector2 global coordinates
var path: Array[Vector2]
# tracking index to path coordinate that this entity is moving TOWARDS
var pathIdx: int = 0

var moveSpeed: float = 250

# get parent
@onready var entity: Entity = $".."
@onready var entity_manager: EntityManager = %EntityManager
@onready var tile_map_layer: UserInteractableTilemapLayer = %UserInteractibleTileMapLayer
var pathing_component: PathingComponent = null

func _ready() -> void:
	tile_map_layer = get_node("%UserInteractibleTileMapLayer")
	pathing_component = tile_map_layer.pathingComponent
	pathing_component.connect("path_updated", _on_path_updated)

# call this before making the entity do anything
func setup(newPath: Array[Vector2]) -> void:
	path = newPath

# call this to make this entity start moving along the path
func startMoving() -> void:
	if path == null || path.is_empty():
		print("ERROR: called startMoving on " + name + ", but no path is set to move along.")
	else:
		moving = true

func setMoveSpeed(value: float) -> void:
	moveSpeed = value

# called every frame
func _process(delta: float) -> void:
	if moving:
		entity.global_position = entity.global_position.move_toward(path[pathIdx], delta * moveSpeed)

		# cannot do entity.global_position == path[pathIdx] due to floating point comparison not working
		# using distance_squared_to because it is faster than distance_to
		if entity.global_position.distance_squared_to(path[pathIdx]) < 0.01: # if reached target coord
		# if reach coordinate in path
			#entity_manager.giveNewPath(2)
			pathIdx += 1 # increment coordinate idx
			if pathIdx >= path.size(): # reached end of path
				moving = false
				## DO SOMETHING AFTER REACHING END OF PATH


func _on_path_updated(path: PackedVector2Array) -> void:
	self.path = path
