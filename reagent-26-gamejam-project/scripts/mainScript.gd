extends Node2D
class_name mainScript

const kast_template = preload("res://scenes/kast.tscn")
const global_data = preload("res://scripts/global_data.tres")

func _ready() -> void:
	
	var rand_ingredient := global_data.Ingredient.values().duplicate()
	rand_ingredient.shuffle()
	var kasten := $Kasten.get_children()
	
	for pos in len(kasten):
		var opberg_type = global_data.Opberg.values().pick_random()
		kasten[pos].opberg_type = opberg_type
		kasten[pos].opberg_texture = global_data.opberg_textures[opberg_type]
		
		kasten[pos].item_type = rand_ingredient[pos % len(global_data.Ingredient)]
		kasten[pos].item_texture = global_data.item_textures[rand_ingredient[pos % len(global_data.Ingredient)]]
		kasten[pos].update_vars()
