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
##
## NOTE: only one instance of this menu is to exist at a time within a single scene
## NOTE: this node needs to be placed AFTER the UserInteractableTileMapLayer or else it not catch mouse inputs

@onready var towerNameLabel: RichTextLabel = %TowerNameRichTextLabel
@onready var moveButton: Button = %MoveButton
@onready var storeButton: Button = %StoreButton
@onready var closeButton: Button = %CloseButton
@onready var slotSnapPoints: Array = [%SnapPoint1, %SnapPoint2, %SnapPoint3]

var tower: Tower
# TEMP - where to display this menu in reference to the tower
var displayOffset: Vector2 = Vector2(-150, 0)

func _ready() -> void:
	add_to_group("TowerMenu")
	
	closeButton.button_up.connect(closeMenu)

func openMenu(newTower: Tower) -> void:
	tower = newTower
	setTowerNameLabel(tower.towerName)
	global_position = tower.global_position + displayOffset
	show()
	
func closeMenu() -> void:
	clear()
	hide()

func setTowerNameLabel(towerName: String) -> void:
	towerNameLabel.text = "[center]" + towerName

func setTowerMods() -> void:
	pass

func onMovePressed() -> void:
	pass
	
func onStorePressed() -> void:
	pass

func clear() -> void:
	tower = null
