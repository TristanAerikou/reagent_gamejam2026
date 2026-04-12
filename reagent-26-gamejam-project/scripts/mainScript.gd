extends Node2D
class_name mainScript

enum Ingredient { ZOUT, BOT, GOUDVIS, KOEKJE, KAAS }
enum Opberg { KAST, TAFEL, KLEINKASTJE }
enum Order { ROOD, GEEL, ORANJE }

const kast_template = preload("res://scenes/kast.tscn")
const order_template = preload("res://scenes/order.tscn")

@export var plaatsen: Array[Vector2i]
@export var opberg_textures: Dictionary[Opberg, AtlasTexture]
@export var item_textures: Dictionary[Ingredient, AtlasTexture]
@export var order_textures: Dictionary[Order, AtlasTexture]

func _ready() -> void:
	#voeg 1 starting order toe
	_next_order_timeout()
	
	var rand_ingredient = Ingredient.values().duplicate()
	rand_ingredient.shuffle()
	
	for pos in len(plaatsen):
		# nieuwe kast aanmaken
		var nieuwe_kast = kast_template.instantiate()
		nieuwe_kast.position = plaatsen[pos]
		
		var opberg_type = Opberg.values().pick_random()
		nieuwe_kast.opberg_type = opberg_type
		nieuwe_kast.opberg_texture = opberg_textures[opberg_type]
		
		nieuwe_kast.item_type = rand_ingredient[pos]
		nieuwe_kast.item_texture = item_textures[rand_ingredient[pos]]
		
		add_child(nieuwe_kast)

func _next_order_timeout() -> void:
	var order = order_template.instantiate()
	$Camera2D/Orders.add_child(order)
	
	var order_type = Order.values().pick_random()
	order.get_node("Background/HBox/PanelContainer/OrderImage").texture = order_textures[order_type]
	
	for ingredient_count in randi_range(1, 8):
		var ingredient_type = Ingredient.values().pick_random()
		
		var ingredient = TextureRect.new()
		ingredient.texture = item_textures[ingredient_type]
		
		order.get_node("Background/HBox/Ingredients").add_child(ingredient)
