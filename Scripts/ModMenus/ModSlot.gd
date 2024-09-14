class_name ModSlot
extends TextureRect

signal slotAdd(modItem: ModItem)
signal slotRemove(modItem: ModItem)

var modItem: ModItem = null
# This is a node2D placed at the center of this button - it has no other script or function
@onready var modSlotCenterNode: Node2D = $ModSlotCenter


func _ready() -> void:
	add_to_group("ModSlot")


# use this to place and move a modItem into this slot
func placeModItemInSlot(newModItem: ModItem) -> void:
	if modItem == null:
		modItem = newModItem
		newModItem.global_position = modSlotCenterNode.global_position
		slotAdd.emit(modItem)


# adds item to a slot without any signaling
# used by TowerMenu to load a ModItem without triggering the signal to add the mod to the tower again, causing a dupwication gwitch
func placeModItemInSlotNoSignal(newModItem: ModItem) -> void:
	if modItem == null:
		modItem = newModItem
		newModItem.global_position = modSlotCenterNode.global_position


# clears slot, and if connected to TowerMenu, signals for mod removal from tower
func removeModItemFromSlot() -> void:
	if modItem != null:
		slotRemove.emit(modItem)
		modItem = null


# used to clear this slot, but not remove the mod from the tower (if if used in TowerMenu)
func removeModItemNoSignal() -> void:
	if modItem != null:
		modItem = null


func empty() -> void:
	modItem = null
