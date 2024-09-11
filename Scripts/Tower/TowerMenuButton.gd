extends Button

var towerMenu: TowerMenu
@onready var tower: Tower =  $".."

func _ready() -> void:
	#towerMenu = get_tree().get_first_node_in_group("TowerMenu")

	button_up.connect(onPressed)

func onPressed() -> void:
	# need this due to weird load order
	if towerMenu == null:
		towerMenu = get_tree().get_first_node_in_group("TowerMenu")
		
	if towerMenu.tower == tower and towerMenu.visible == true: # menu is showing AND it is showing this tower
		towerMenu.closeMenu()
	else:
		towerMenu.closeMenu() # clears the menu just in case another was selected
		towerMenu.openMenu(tower)

func disableTowerMenu() -> void:
	button_up.disconnect(onPressed)
	
func enableTowerMenu() -> void:
	button_up.connect(onPressed)
