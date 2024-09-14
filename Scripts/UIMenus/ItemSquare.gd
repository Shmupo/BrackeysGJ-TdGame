extends Node

@onready var itemImage: TextureRect = $MarginContainer/HBoxContainer/CenterContainer/ItemImage
@onready var nameLabel: RichTextLabel = $MarginContainer/HBoxContainer/VBoxContainer/ItemName
@onready var descriptionLabel: RichTextLabel = $MarginContainer/HBoxContainer/VBoxContainer/ItemDescription

func setup(image: Texture2D, itemName: String, description: String) -> void:
	itemImage.texture = image
	nameLabel.text = itemName
	descriptionLabel.text = description
