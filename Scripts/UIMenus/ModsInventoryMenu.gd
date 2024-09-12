class_name ModsInventoryMenu
extends MarginContainer

var allModSlots: Array

func _ready() -> void:
	add_to_group("ModsInventoryMenu")
	
	allModSlots = $MarginContainer/ModsInventoryMenu/MidVBoxContainer/MarginContainer/ModsGridContainer.get_children()

func getNextEmptyModSlot() -> ModSlot:
	for slot: ModSlot in allModSlots:
		if slot.modItem == null:
			return slot
	
	return null
