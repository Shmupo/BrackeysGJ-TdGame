class_name PhaseBar
extends Node2D


## Phasebar is used to indicate the current game phase, but also disable and enable certain features
##
## During build phase:
## Cannot move towers
## Start wave button is disabled
## Path placement is disabled
##
## Defend phase is opposite of build phase

# Doing zero for now, will implement progress bar if I have more time
var hideYShift: int = 0
var buildPhase: bool = true : set = setPhase
@onready var label: RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel
@onready var towerMenu: TowerMenu = $"../TowerMenu"
@onready var userInteractableTileMapLayer: UserInteractableTilemapLayer = $"../UserInteractableTileMapLayer"

func setBuildPhase() -> void:
	doRewards()
	
	position.y -= hideYShift
	label.text = "[center][color=green]Build Phase"
	configureBuildPhase()


func doRewards() -> void:
	get_parent().add_child(load("res://Scenes/Components/RewardsScreen.tscn").instantiate())


func setDefendPhase() -> void:
	position.y += hideYShift
	label.text = "[center][color=red]Defend Phase"
	configureDefendPhase()


func setStormPhase() -> void:
	position.y += hideYShift
	label.text = "[center][color=purple]Storm Phase - THE END IS HERE!"
	configureDefendPhase()
	
	get_parent().add_child(load("res://Scenes/Components/StormWaveClouds.tscn").instantiate())


func configureDefendPhase() -> void:
	towerMenu.disableMove() # disables the move button for towers
	userInteractableTileMapLayer.inputComponent.disableInput() # user cannot place tiles


func configureBuildPhase() -> void:
	towerMenu.enableMove() # enables move button for towers
	userInteractableTileMapLayer.inputComponent.enableInput() # user can place tiles


func setPhase(value: bool) -> void:
	buildPhase = value
	if buildPhase == false:
		setBuildPhase()
	else:
		setDefendPhase()
