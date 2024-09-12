extends Node

var modInvMenu: ModsInventoryMenu

func _ready() -> void:
	modInvMenu = get_tree().get_first_node_in_group("ModsInventoryMenu")

func addItemToInventory(item: ModItem) -> void:
	var slot: ModSlot = modInvMenu.getNextEmptyModSlot()
	if slot != null:
		slot.placeModItemInSlot(item)
	else:
		print("ERROR - no more slots available to to call addItemToInventory() inside ItemSpawner")
	

func _on_add_item_button_button_up() -> void:
	var testItem: ModItem = load("res://Scenes/Components/ModItem/TestModItem.tscn").instantiate()
	modInvMenu.add_child(testItem)
	addItemToInventory(testItem)
