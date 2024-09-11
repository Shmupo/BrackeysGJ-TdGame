extends Node2D


@onready var pathing_component: PathingComponent = $UserInteractableTileMapLayer/PathingComponent
@onready var tile_map_layer: TileMapLayer = $UserInteractableTileMapLayer
@onready var input_component: InputComponent = $UserInteractableTileMapLayer/InputComponent
@onready var entity_manager: EntityManager = %EntityManager

func do_nothing() -> void:
	pass


func _ready() -> void:
	# Create path based tile map
	var map = tile_map_layer.tile_map_data
	for i in 100:
		for j in 100:
			var cell = Vector2i(-1 * j, -1 * i)
			var result = tile_map_layer.get_cell_atlas_coords(cell)
			if result.x == 4 and result.y == 0:
				pathing_component.aStarGrid.set_point_solid(cell, false)
	pathing_component.updatePath()
	
	

func spawn_base_entity() -> void:
	entity_manager.spawnEntity("BaseEntity")
	
func spawn_other_entity() -> void:
	entity_manager.spawnEntity("OtherEntity")
