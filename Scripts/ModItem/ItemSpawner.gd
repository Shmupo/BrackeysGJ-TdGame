class_name ItemSpawner
extends Node

var modInvMenu: ModsInventoryMenu

func _ready() -> void:
	modInvMenu = get_tree().get_first_node_in_group("ModsInventoryMenu")
	
	add_to_group("ItemSpawner")
	
	spawnStarterItem()

func addItemToInventory(item: ModItem) -> void:
	var slot: ModSlot = modInvMenu.getNextEmptyModSlot()
	if slot != null:
		if item.get_parent() != null:
			item.reparent(self)
		slot.placeModItemInSlot(item)
	else:
		print("ERROR - no more slots available to to call addItemToInventory() inside ItemSpawner")


func spawnStarterItem() -> void:
	var item: ModItem = load("res://Scenes/Components/ModItem/Rope.tscn").instantiate()
	add_child(item)
	await get_tree().create_timer(0.1).timeout
	addItemToInventory(item)
