extends Node2D

@onready var tabContainer: TabContainer = $TabContainer
@onready var nextButton: Button = $NextButton
@onready var prevButton: Button = $PreviousButton
@onready var pageLabel: RichTextLabel = $TabCount
@onready var showTutorialButton: Button = $ShowButton
@onready var bgRect: Sprite2D = $BgSprite2D

func _ready() -> void:
	nextButton.button_up.connect(onPressNext)
	prevButton.button_up.connect(onPressPrevious)
	updatePageCountLabel()
	
	showTutorialButton.button_up.connect(toggleTutorial)
	
	tabContainer.current_tab = 0
	prevButton.disabled = true

func toggleTutorial() -> void:
	if tabContainer.is_visible_in_tree():
		tabContainer.hide()
		showTutorialButton.text = "Show Tutorial"
		nextButton.hide()
		prevButton.hide()
		pageLabel.hide()
		bgRect.hide()
	else:
		tabContainer.show()
		showTutorialButton.text = "Hide Tutorial"
		nextButton.show()
		prevButton.show()
		pageLabel.show()
		bgRect.show()

func onPressNext() -> void:
	tabContainer.current_tab += 1
	updatePageCountLabel()
	
	if tabContainer.current_tab >= tabContainer.get_tab_count() - 1:
		nextButton.disabled = true
	else:
		nextButton.disabled = false
		
	prevButton.disabled = false

func onPressPrevious() -> void:
	tabContainer.current_tab -= 1
	updatePageCountLabel()
	
	if tabContainer.current_tab == 0:
		prevButton.disabled = true
	else:
		prevButton.disabled = false
		
	nextButton.disabled = false

func updatePageCountLabel() -> void:
	# Display current tab as 1-based index
	pageLabel.text = "[center]" + str(tabContainer.current_tab + 1) + "/" + str(tabContainer.get_tab_count())
