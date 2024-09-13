extends DictWave

func _ready() -> void:
	spawn_queue = [
		{
			"type": "BaseEntity",
			"spawn_delay": 0.1,
			"config": {
				"speed": 100,
				"health": 10
			}
		},
		{
			"type": "OtherEntity",
			"spawn_delay": 4.0,
			"config": {
				"speed": 50,
				"health": 10,
			}
		},
		{
			"type": "KnightEntity",
			"spawn_delay": 4.0,
			"config": {
				"speed": 50,
				"health": 20,
			}
		}
	]
