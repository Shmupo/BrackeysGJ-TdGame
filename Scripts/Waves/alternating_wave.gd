extends DictWave


@export var num_entities_2: int = 10  # hacks

@export var entity_1_speed: int = 50
@export var entity_1_health: int = 5
@export var entity_1_points = 30
@export var entity_1_strength = 5
@export var entity_1_type = "BaseEntity"
@export var entity_1_spawn_delay = 2


@export var entity_2_speed: int = 50
@export var entity_2_health: int = 5
@export var entity_2_points = 30
@export var entity_2_strength = 5
@export var entity_2_type = "BaseEntity"
@export var entity_2_spawn_delay = 2


func _ready() -> void:
	spawn_queue = []
	
	for i in num_entities_2:
		if i % 2 == 0:
			spawn_queue.append(prepare_entity_1())
		else:
			spawn_queue.append(prepare_entity_2())
			
	num_entities = get_num_entities()


func prepare_entity_1() -> Dictionary:
	return {
		"type": entity_1_type,
		"spawn_delay": entity_1_spawn_delay,
		"config": {
			"speed": entity_1_speed,
			"health": entity_1_health,
			"points": entity_1_points,
			"strength": entity_1_strength
		}
	}

func prepare_entity_2() -> Dictionary:
	return {
		"type": entity_2_type,
		"spawn_delay": entity_2_spawn_delay,
		"config": {
			"speed": entity_2_speed,
			"health": entity_2_health,
			"points": entity_2_points,
			"strength": entity_2_strength
		}
	}
