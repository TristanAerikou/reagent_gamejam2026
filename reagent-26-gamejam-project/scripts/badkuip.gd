extends StaticBody2D

const types = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

var ingredients: Array[types.Ingredient] = []

func add_ingredient(ingredient: types.Ingredient):
	ingredients.push_back(ingredient)
	var tex := TextureRect.new()
	tex.texture = global_data.item_textures[ingredient]
	$BadItemBackground/BadItems.add_child(tex)

func clear_badkuip() -> Array[types.Ingredient]:
	var copy := ingredients.duplicate()
	ingredients.clear()
	for child in $BadItemBackground/BadItems.get_children():
		child.queue_free()
	return copy
