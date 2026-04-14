extends Node2D
class_name mainScript

const kast_template = preload("res://scenes/kast.tscn")
const order_template = preload("res://scenes/order.tscn")
const global_data = preload("res://scripts/global_data.tres")

func _ready() -> void:
	#voeg 1 starting order toe
	_next_order_timeout()
	
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

func _next_order_timeout() -> void:
	var order := order_template.instantiate()
	$Camera2D/Orders.add_child(order)
	
	var order_type = global_data.Order.values().pick_random()
	order.get_node("Background/HBox/PanelContainer/OrderImage").texture = global_data.order_textures[order_type]
	
	for ingredient_count in randi_range(1, 4):
		var ingredient_type = global_data.Ingredient.values().pick_random()
		
		var ingredient = TextureRect.new()
		ingredient.texture = global_data.item_textures[ingredient_type]
		
		order.get_node("Background/HBox/Ingredients").add_child(ingredient)
