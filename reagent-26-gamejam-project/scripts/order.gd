extends MarginContainer

const types = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

var ingredients: Array[types.Ingredient] = []

func _ready():
	for ingredient_count in randi_range(1, 4):
		var ingredient_type = types.Ingredient.values().pick_random()
		
		var ingredient := TextureRect.new()
		ingredient.texture = global_data.item_textures[ingredient_type]
		$Background/HBox/Ingredients.add_child(ingredient)
		
		ingredients.push_back(ingredient_type)

	$Background/HBox/PanelContainer/OrderImage.texture = global_data.get_potion_texture(ingredients)
