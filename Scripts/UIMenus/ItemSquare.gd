extends Node

@onready var itemImage: TextureRect = $MarginContainer/HBoxContainer/CenterContainer/ItemImage
@onready var nameLabel: RichTextLabel = $MarginContainer/HBoxContainer/VBoxContainer/ItemName
@onready var descriptionLabel: RichTextLabel = $MarginContainer/HBoxContainer/VBoxContainer/ItemDescription

func setup(image: Texture2D, name: String, description: String) -> void:
	itemImage.texture = image
	nameLabel.text = name
	descriptionLabel.text = description
