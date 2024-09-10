extends Node2D


@onready var pathing_component: PathingComponent = $UserInteractableTileMapLayer/PathingComponent
@onready var tile_map_layer: TileMapLayer = $UserInteractableTileMapLayer
@onready var input_component: InputComponent = $UserInteractableTileMapLayer/InputComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_component.queue_free()
	var map = tile_map_layer.tile_map_data
	for i in 100:
		for j in 100:
			var cell = Vector2i(-1 * j, -1 * i)
			var result = tile_map_layer.get_cell_atlas_coords(cell)
			if result.x == 3 and result.y == 0:
				tile_map_layer.set_cell(cell, 0, Vector2i(7, 0))
				pathing_component.placePath(cell)
	pathing_component.updatePath()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
