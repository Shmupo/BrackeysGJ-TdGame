extends DictWave

@onready var rng = RandomNumberGenerator.new()

var num_entities_2: int = 10  # hacks.  ignore here.
@export var entity_speed: int = 50
@export var entity_health: int = 5
@export var entity_points = 30
@export var entity_strength = 5
@export var entity_type = "BaseEntity"
@export var spawn_delay = 2


@export var entities_before_increase: int = 10
var difficulty = 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_queue = []
	
	spawn_queue.append({
		"type": "WizardEntity",
		"spawn_delay": 0.1,
		"config": {
			"health": 75,
			"speed": 120,
			"strength": 35,
			"points": 5000
		}
	})
	
	for i in range(entities_before_increase + 5):
		spawn_queue.append(create_entity_dict())
		
	num_entities = get_num_entities()


func _process(delta: float) -> void:
	if spawn_queue.size() < 5:
		increase_difficulty()
		for i in entities_before_increase:
			spawn_queue.append(gen_entity())


func increase_difficulty() -> void:
	difficulty += 1


func gen_entity() -> Dictionary:
	# TODO: make this better
	return create_entity_dict()


func create_entity_dict() -> Dictionary:
	var min_spawn_delay: float = 0.1
	
	var modified_delay: float = spawn_delay - (float(difficulty) / 10)
	if modified_delay < min_spawn_delay:
		modified_delay = min_spawn_delay
	
	return {
		"type": entity_type,
		"spawn_delay": modified_delay,
		"config": {
			"speed": int(float(entity_speed) * (1.0 + (float(difficulty) / 15))),
			"health": int(float(entity_health) * (1.0 + (float(difficulty) / 10))),
			"strength": int(float(entity_strength) * (1.0 + float(difficulty) / 10)),
			"points": int(float(entity_points) * (1.0 + float(difficulty) / 10))
		}
	}
