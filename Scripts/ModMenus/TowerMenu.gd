class_name TowerMenu
extends Node2D

## The TowerModMenu displays a UI that the use can use to interact with the tower
##
## Using this UI, the user can: 
## Move the tower
## Store the tower in their inventory
## Place a mod into the mod slot of a tower
##
## This UI opens whenever a user clicks on a tower
## In production, this will be hidden until the user selects a tower
##
## NOTE: only one instance of this menu is to exist at a time within a single scene
## NOTE: this node needs to be placed AFTER the UserInteractableTileMapLayer or else it not catch mouse inputs

@onready var towerNameLabel: RichTextLabel = %TowerNameRichTextLabel
@onready var moveButton: Button = %MoveButton
@onready var storeButton: Button = %StoreButton
@onready var closeButton: Button = %CloseButton
@onready var modSlots: Array[ModSlot] = [
	$MarginContainer/VBoxContainer/ModSlotRow/SlotMarginContainer/ModSlot,
	$MarginContainer/VBoxContainer/ModSlotRow2/SlotMarginContainer/ModSlot,
	$MarginContainer/VBoxContainer/ModSlotRow3/SlotMarginContainer/ModSlot
	]
@onready var modSlotRow: Array[ModSlotRow] = [
	$MarginContainer/VBoxContainer/ModSlotRow,
	$MarginContainer/VBoxContainer/ModSlotRow2,
	$MarginContainer/VBoxContainer/ModSlotRow3
]

var tower: Tower
# TEMP - where to display this menu in reference to the tower
var displayOffset: Vector2 = Vector2(-150, 0)


func _ready() -> void:
	add_to_group("TowerMenu")
	
	closeButton.button_up.connect(closeMenu)
	
	for slot: ModSlot in modSlots:
		slot.slotAdd.connect(addTowerMod)
		slot.slotRemove.connect(removeTowerMod)


# when selecting a towerr
func openMenu(newTower: Tower) -> void:
	tower = newTower
	setTowerNameLabel(tower.towerName) # set menu title on top
	global_position = tower.global_position + displayOffset
	loadTowerMods() # display the mods of the tower
	show()


# when deselecting a tower
func closeMenu() -> void:
	clearTowerModsDisplayed()
	clear()
	hide()


func setTowerNameLabel(towerName: String) -> void:
	towerNameLabel.text = "[center]" + towerName


# for now, we will make the mods simply turn invisible when deselecting the tower
# when the tower is deselected, clear the slots too
func clearTowerModsDisplayed() -> void:
	if tower != null:
		for mod: ModItem in tower.getMods():
			mod.hide()
	for slot: ModSlot in modSlots:
		slot.removeModItemNoSignal() # use this over removeModItem to prevent mod from also being removed from the tower


# get mods of a tower and display them in the menu when the tower is selected
func loadTowerMods() -> void:
	if tower != null:
		var towerMods: Array = tower.getMods()
		
	# NOTE: bugs ill happen if there are more mods than mod slots, this currently helps prevent it from crashing if that happens
	# Prevents bugs when there are more mod slots than tower mods
		for x in range(modSlots.size()):
			if x < towerMods.size():  # Ensure 'x' is within bounds of towerMods
				modSlots[x].placeModItemInSlotNoSignal(towerMods[x])  # Prevents duplication bug
				modSlotRow[x].onSlotAdd(towerMods[x]) # sets slot row name
				towerMods[x].show()
			else:
				modSlotRow[x].clearSlotName()  # rest slots that are empty to show "Empty Slot"


# when a mod is placed in a slot, add it to the tower
func addTowerMod(modItem: ModItem) -> void:
	if tower != null:
		tower.addMod(modItem)
	
func removeTowerMod(modItem: ModItem) -> void:
	if tower != null:
		tower.removeMod(modItem)

# allows user to move the tower
func onMovePressed() -> void:
	pass

# allows user to store the tower?
func onStorePressed() -> void:
	pass

# remove the selected tower
func clear() -> void:
	tower = null
