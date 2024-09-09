class_name TargetingComponent
extends Node

## This script is used to get the first entity to enter the target area
##
## Config for TargetingArea2D:
## Monitorable = false
## Layer = none
## Mask = 1
##
## These config settings ensure other tower areas do not collide

signal areaEntered

@onready var targetingArea: Area2D = $"../TargetingArea2D"
@onready var targetingShape: CollisionShape2D = $"../TargetingArea2D/CollisionShape2D"
var targetingRadius: float = 50 : set = setTargetRadius

# array of entity hitboxes (Area2D) in the order they entered the targeting area
var targetQueue: Array = []

func _ready() -> void:
	targetingArea.area_entered.connect(onAreaEntered)
	targetingArea.area_exited.connect(onAreaExited)

# get first entity that enters the targeting area
func getTarget() -> Node2D:
	if !targetQueue.is_empty():
		return targetQueue.front()
	else:
		return null

# add to queue
func onAreaEntered(area: Area2D) -> void:
	targetQueue.append(area)
	areaEntered.emit()
	#print(targetQueue)

# remove from queue
func onAreaExited(area: Area2D) -> void:
	targetQueue.erase(area)
	#print(targetQueue)

# change targeting radius shape
# TEST - not tested yet
func setTargetRadius(value: float) -> void:
	targetingRadius = value
	targetingShape.shape.radius = value
