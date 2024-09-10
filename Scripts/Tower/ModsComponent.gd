class_name ModsComponent
extends Node

## ModsComponent is used to store the mods of a tower and apply those mods to the tower stats
##
##
##

var mods: Array

func getMods() -> Array:
	return mods

func addMod(modItem: ModItem) -> void:
	if modItem not in mods: # prevent duplicates
		mods.append(modItem)
		#print(mods)

func removeMod(modItem: ModItem) -> void:
	mods.remove_at(mods.find(modItem))
	#print(mods)
