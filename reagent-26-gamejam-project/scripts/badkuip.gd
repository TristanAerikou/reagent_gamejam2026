extends StaticBody2D

# Dictionary[ReceptEnum, Array[mainScript.Ingredient]]
# ^ godot vindt dit type te ingewikkeld en ik mag het niet gebruiken :(

var ingredients: Array[mainScript.Ingredient] = []

func add_ingredient(ingredient: mainScript.Ingredient):
	ingredients.push_back(ingredient)


func get_potion_texture(ingredients) -> AtlasTexture:
	var order_type := mainScript.Order.ORANJE
	if mainScript.Ingredient.ZOUT in ingredients:
		order_type = mainScript.Order.GEEL
	elif mainScript.Ingredient.BOT in ingredients:
		order_type = mainScript.Order.ROOD
	elif mainScript.Ingredient.KAAS in ingredients:
		order_type = mainScript.Order.GEEL
	
	return get_parent().order_textures[order_type]
