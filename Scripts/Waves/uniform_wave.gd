extends DictWave

@export var num_entities_2: int = 10  # hacks
@export var entity_speed: int = 50
@export var entity_health: int = 5
@export var entity_points = 30
@export var entity_strength = 5
@export var entity_type = "BaseEntity"
@export var spawn_delay = 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_queue = []
	
	for i in range(num_entities_2):
		spawn_queue.append(create_entity_dict())


func create_entity_dict() -> Dictionary:
	return {
		"type": entity_type,
		"spawn_delay": spawn_delay,
		"config": {
			"speed": entity_speed,
			"health": entity_health,
			"strength": entity_strength,
			"points": entity_points
		}
	}
