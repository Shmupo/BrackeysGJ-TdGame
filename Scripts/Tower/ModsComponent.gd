class_name ModsComponent
extends Node

## ModsComponent is used to store the mods of a tower and apply those mods to the tower stats
##
## Refreshing must be done - this will reset the tower to base values and re-apply mod upgrades

var mods: Array[ModItem] = []
@onready var tower: Tower = $".."
@onready var shootingComponent: ShootingComponent = $"../ShootingComponent"


func getMods() -> Array:
	return mods


func addMod(modItem: ModItem) -> void:
	if modItem not in mods: # prevent duplicates
		mods.append(modItem)
		#print(mods)
		refreshModUpgrades()


func removeMod(modItem: ModItem) -> void:
	mods.remove_at(mods.find(modItem))
	#print(mods)
	refreshModUpgrades()


# Refresh all the stats because I am too lazy to manually undo the mod upgrades
func refreshModUpgrades() -> void:
	tower.targetingComponent.reset()
	shootingComponent.reset()
	
	for mod in mods:
		mod.applyTowerUpgrades(tower)
