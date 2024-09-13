extends DictWave

func _ready() -> void:
	spawn_queue = [
		{
			"type": "KnightEntity",
			"spawn_delay": 0.1,
			"config": {
				"speed": 100,
				"health": 20
			}
		}
	]
