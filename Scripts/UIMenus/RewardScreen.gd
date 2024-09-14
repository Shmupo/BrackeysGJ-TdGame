extends Node
# pick a random one to give to player
var itemScenes: Dictionary = {
	"Telescope" : "res://Scenes/Components/ModItem/Telescope.tscn",
	"Big Rock" : "res://Scenes/Components/ModItem/BigRock.tscn",
	"Laser Crystal" : "res://Scenes/Components/ModItem/LaserCrystal.tscn",
	"Rope" : "res://Scenes/Components/ModItem/Rope.tscn"
}

var rewardCount: int = 2

@onready var itemRow: HBoxContainer = $MarginContainer/VBoxContainer/ItemRow
@onready var continueButton: Button = $MarginContainer/VBoxContainer/Button

func _ready() -> void:
	generateRandomRewards()
	
	continueButton.button_up.connect(onPressContinue)

func generateRandomRewards() -> void:
	var itemArr: Array = []
	for x in rewardCount:
		var itemSquare: MarginContainer = load("res://Scenes/Components/ItemSquare.tscn").instantiate()
		itemRow.add_child(itemSquare)
		
		# do not add randItem as a child to anything yet
		var randomItem: ModItem = load(itemScenes[itemScenes.keys().pick_random()]).instantiate()
		add_child(randomItem)
		itemSquare.setup(randomItem.getTexture(), randomItem.itemName, randomItem.itemDescription)
		itemArr.append(randomItem)
		
	addItemsToInv(itemArr)
	
	if randi_range(0, 1) == 0: # 50% change to give the player a new tower
		addTowerToGame()

# adds items instantly to inventory
func addItemsToInv(itemArr: Array) -> void:
	var itemSpawner: ItemSpawner = get_tree().get_first_node_in_group("ItemSpawner")
	for item: ModItem in itemArr:

		itemSpawner.addItemToInventory(item)

func addTowerToGame() -> void:
	get_tree().get_first_node_in_group("TowerSpawner").spawnTower()
	itemRow.add_child(load("res://Scenes/Components/TowerSquare.tscn").instantiate())

# self delete
func onPressContinue() -> void:
	queue_free()
