extends StaticBody2D

const types = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

var ingredients: Array[types.Ingredient] = []

func add_ingredient(ingredient: types.Ingredient):
	ingredients.push_back(ingredient)


func get_potion_texture(ingredients) -> AtlasTexture:
	var order_type := types.Order.ORANJE
	if global_data.Ingredient.ZOUT in ingredients:
		order_type = types.Order.GEEL
	elif global_data.Ingredient.BOT in ingredients:
		order_type = types.Order.ROOD
	elif global_data.Ingredient.KAAS in ingredients:
		order_type = types.Order.GEEL
	
	return global_data.order_textures[order_type]
