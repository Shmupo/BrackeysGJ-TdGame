extends Node

@onready var displayLabels: Array = [
	$MarginContainer/VBoxContainer/RichTextLabel,
	$MarginContainer/VBoxContainer/RichTextLabel2,
	$MarginContainer/VBoxContainer/RichTextLabel3,
]

var displayIdx: int = 0
var currentLabel: RichTextLabel
var displaying: bool = false
var darkening: bool = false
var fade_speed: float = 0.5
@onready var continueButton: Button = $CenterContainer/ContinueButton
@onready var blackoutSquare: ColorRect = $ColorRect


func _ready() -> void:
	continueButton.disabled = true
	continueButton.button_up.connect(onPressContinue)
	displayNext()


func displayNext() -> void:
	if displayIdx < displayLabels.size():
		currentLabel = displayLabels[displayIdx]
		currentLabel.show()
		currentLabel.self_modulate = Color(1, 1, 1, 0)
		displaying = true
		continueButton.disabled = true
	else:
		darkening = true


func goToMainSceneDelayed() -> void:
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/TestScene.tscn")


func onPressContinue() -> void:
	if not displaying:
		currentLabel.hide()
		displayIdx += 1
		displayNext()


func _process(delta: float) -> void:
	if displaying:
		# Gradually increase the alpha value
		var new_alpha = clamp(currentLabel.self_modulate.a + fade_speed * delta, 0.0, 1.0)
		currentLabel.self_modulate = Color(1, 1, 1, new_alpha)
		
		# Check if fully opaque
		if new_alpha >= 1.0:
			displaying = false # Stop fading
			continueButton.disabled = false # Re-enable continue button
	if darkening:
		var new_alpha = clamp(blackoutSquare.color.a + delta, 0.0, 1.0)
		var new_color = blackoutSquare.color
		new_color.a = new_alpha
		blackoutSquare.color = new_color
		print(blackoutSquare.color.a)
		if (blackoutSquare.color.a == 1.0): # trigger change to main scene when fully dark
			goToMainSceneDelayed()
