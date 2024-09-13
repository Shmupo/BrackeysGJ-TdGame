## This class displays some info about the waves manager in the scene.
## Connect the signal handlers to the waves manager

extends Label

var waves_active: int = 0
var waves_state: String = "Not Started"

func _ready() -> void:
	update()

## Update the text to reflect the desired info
func update() -> void:
	var output = ""
	
	output = output.join(
		["Waves: ", waves_state, "\n",
		 "Active Waves: ", waves_active, "\n"])
	
	text = output


func _on_start_waves() -> void:
	waves_state = "Started"
	update()

func _on_wave_start() -> void:
	waves_active += 1
	update()
	
	
func _on_wave_end() -> void:
	waves_active -= 1
	update()
	
func _on_end_waves() -> void:
	waves_state = "Ended"
	update()
