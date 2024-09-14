extends DictWave

@export var enemy_health = 1

func _ready() -> void:
	spawn_queue = [
		{
			"type": "BaseEntity",
			"spawn_delay": 0.1,
			"config": {
				"speed": 100,
				"health": enemy_health
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		{
			"type": "BaseEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 100,
				"health": enemy_health,
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		{
			"type": "BaseEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 100,
				"health": enemy_health,
			}
		},
		#6
		{
			"type": "OtherEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		{
			"type": "BaseEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 100,
				"health": enemy_health,
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		#11
		{
			"type": "BaseEntity",
			"spawn_delay": 0.5,
			"config": {
				"speed": 100,
				"health": enemy_health,
			}
		},
		{
			"type": "BaseEntity",
			"spawn_delay": 0.1,
			"config": {
				"speed": 100,
				"health": enemy_health,
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.1,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.1,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 0.1,
			"config": {
				"speed": 50,
				"health": enemy_health,
			}
		},
	]
