extends Area2D
class_name Badkuip

const enums = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

var ingredients: Array[enums.Ingredient] = []

func _on_body_entered(body: Node2D):
	%BadItemBackground.visible = true
	
func _on_body_exited(body: Node2D):
	%BadItemBackground.visible = false

func add_ingredient(ingredient: enums.Ingredient):
	ingredients.push_back(ingredient)
	var tex := TextureRect.new()
	tex.texture = global_data.item_textures[ingredient]
	%BadItems.add_child(tex)

func clear_badkuip() -> Array[enums.Ingredient]:
	var copy := ingredients.duplicate()
	ingredients.clear()
	for child in %BadItems.get_children():
		child.queue_free()
	return copy
