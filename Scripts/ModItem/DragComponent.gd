extends Node2D

@onready var modItem: ModItem = $".."
@onready var dragButton: Button = $"../DragButton"

var dragging: bool = false
var offset: Vector2 = Vector2(0, 0)
var snapDistance: float = 50
var modSlot: ModSlot = null


func _ready() -> void:
	dragButton.button_down.connect(onDrag)
	dragButton.button_up.connect(onReleaseFromDrag)
	
	
func onDrag() -> void:
	dragging = true
	offset = get_global_mouse_position() - modItem.global_position
	if modSlot != null:
		modSlot.removeModItemFromSlot()


# try to snap to a modSlot if close enough
func onReleaseFromDrag() -> void:
	if modSlot != null:
		modSlot.removeModItemFromSlot()
	dragging = false
	snapToSlotInRange()


# is the user drops this items within snapDistance of a "ModSlot" group item, snap to it
func snapToSlotInRange() -> void:
	var modSlots: Array[Node] = get_tree().get_nodes_in_group("ModSlot")
	
	for slot: ModSlot in modSlots:
		if modItem.global_position.distance_to(slot.global_position) < snapDistance:
			if slot.modItem == null:
				slot.placeModItemInSlot(modItem)
				modSlot = slot
				break


func _process(delta: float) -> void:
	if dragging:
		modItem.global_position = get_global_mouse_position() - offset
