@tool
extends Area2D
class_name ItemPickup

const enums = preload("res://scripts/global_data.gd")

@export var item: enums.Ingredient
@export var texture: AtlasTexture

func _ready():
	$PanelContainer/VBoxContainer/TextureRect.texture = texture
	$PanelContainer/VBoxContainer/Label.text = "Pick up: \n" + enums.Ingredient.keys()[item]
	if not Engine.is_editor_hint():
		$PanelContainer.visible = false

func _on_body_entered(body: Node2D) -> void:
	$PanelContainer.visible = true


func _on_body_exited(body: Node2D) -> void:
	$PanelContainer.visible = false


func get_texture() -> AtlasTexture:
	return $PanelContainer/VBoxContainer/TextureRect.texture
