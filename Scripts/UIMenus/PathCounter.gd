extends RichTextLabel

var tilePlacingComponent: TilePlacementComponent

func _ready() -> void:
	tilePlacingComponent = get_tree().get_first_node_in_group("TilePlacementComponent")
	tilePlacingComponent.pathLimitChange.connect(setPathCountText)
	
	text = "Paths left: " + str(tilePlacingComponent.pathLimit)

func setPathCountText(value: int) -> void:
	text = "Paths left: " + str(value)
