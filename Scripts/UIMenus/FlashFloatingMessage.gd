extends RichTextLabel

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(onTimeout)

func onTimeout() -> void:
	queue_free() # self-delete

func setup(message: String) -> void:
	text = "[center][color=red]" + message

func _process(delta: float) -> void:
	position.y -= 10 * delta
