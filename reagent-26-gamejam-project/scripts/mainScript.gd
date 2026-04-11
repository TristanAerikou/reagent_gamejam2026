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
	for p in plaatsen:
		# nieuwe kast aanmaken
		var nieuwe_kast = kast_template.instantiate()
		nieuwe_kast.position = p
		
		# random
		var opberg_type = randi_range(0, len(Opberg)-1)
		var item_type = randi_range(0, len(Ingredient)-1)
		
		# opbergruimte texture setten
		nieuwe_kast.opberg_type = opberg_type
		nieuwe_kast.opberg_texture = opberg_textures.get(opberg_type)
		
		# item texture setten
		nieuwe_kast.item_type = item_type
		nieuwe_kast.item_texture = item_textures.get(item_type)
		
		add_child(nieuwe_kast)

func _next_order_timeout() -> void:
	var order = order_template.instantiate()
	$Camera2D/Orders.add_child(order)
	
	var order_type = randi_range(0, len(Order) - 1)
	order.get_node("Background/HBox/PanelContainer/OrderImage").texture = order_textures.get(order_type)
	
	for ingredient_count in randi_range(1, 8):
		var ingredient_type = randi_range(0, len(Ingredient) - 1)
		
		var ingredient = TextureRect.new()
		ingredient.texture = item_textures.get(ingredient_type)
		
		order.get_node("Background/HBox/Ingredients").add_child(ingredient)
