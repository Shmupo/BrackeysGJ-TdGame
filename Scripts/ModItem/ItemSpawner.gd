class_name ItemSpawner
extends Node

var modInvMenu: ModsInventoryMenu

func _ready() -> void:
	modInvMenu = get_tree().get_first_node_in_group("ModsInventoryMenu")
	
	add_to_group("ItemSpawner")

func addItemToInventory(item: ModItem) -> void:
	var slot: ModSlot = modInvMenu.getNextEmptyModSlot()
	if slot != null:
		if item.get_parent() != null:
			item.reparent(self)
		slot.placeModItemInSlot(item)
	else:
		print("ERROR - no more slots available to to call addItemToInventory() inside ItemSpawner")
