extends Button

## Acting as the wave controller


@onready var waveManager: WaveManager = %WaveManager
@onready var phaseBar: PhaseBar = $"../PhaseBar"
@onready var entityManager: EntityManager = %EntityManager
# for checking if path is valid
var pathingComponent: PathingComponent


func _ready() -> void:
	button_up.connect(onPressStart)
	
	pathingComponent = get_tree().get_first_node_in_group("UserInteractableTileMapLayer").pathingComponent

	#entityManager.allEnemiesDead.connect(onWaveDone) # wait for all enemies to die
	waveManager._on_wave_end.connect(delayedWaveDone)

func onPressStart() -> void:
	if isPathValid():
		if waveManager.currentWave < 5:
			phaseBar.setDefendPhase()
			waveManager.startNextWave()
			disabled = true
		else:
			# DO STORM PHASE at wave 6
			phaseBar.setStormPhase()
			waveManager.startNextWave()
			disabled = true
	else:
		var floatingMessage: RichTextLabel = load("res://Scenes/Components/FlashFloatingMessage.tscn").instantiate()
		add_child(floatingMessage)
		floatingMessage.position.y -= 50
		floatingMessage.position.x -= 50
		floatingMessage.setup("Create a valid path first")


func onWaveDone() -> void:
	disabled = false
	phaseBar.setBuildPhase()

func delayedWaveDone() -> void:
	await get_tree().create_timer(3).timeout
	disabled = false
	phaseBar.setBuildPhase()


# assume a non-empty path is valid
func isPathValid() -> bool:
	return !pathingComponent.getPath().is_empty()
