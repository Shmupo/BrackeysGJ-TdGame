class_name ModSlotRow
extends Node

## This is used in the TowermodMenu
##
## This displays the item name when a mod item goes into the modSlot

@onready var modLabel: RichTextLabel = $ModNameMarginContainer/RichTextLabel
@onready var modSlot: ModSlot = $SlotMarginContainer/ModSlot

func _ready() -> void:
	modSlot.slotAdd.connect(onSlotAdd)
	modSlot.slotRemove.connect(onSlotRemove)
	
func onSlotAdd(modItem: ModItem) -> void:
	modLabel.text = modItem.name

# wrapper to discard arg
func onSlotRemove(_modItem: ModItem) -> void:
	clearSlotName()

func clearSlotName() -> void:
	modLabel.text = "Empty Slot"
