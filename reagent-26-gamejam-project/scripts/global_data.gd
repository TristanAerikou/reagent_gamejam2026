extends Resource
class_name TextureMap

enum Ingredient { Zout, Bot, Goudvis, Batterij, Water }
enum Opberg { KAST, TAFEL, KLEINKASTJE }
enum Order { ROOD, GEEL, ORANJE }

@export var opberg_textures: Dictionary[Opberg, AtlasTexture]
@export var item_textures: Dictionary[Ingredient, AtlasTexture]
@export var order_textures: Dictionary[Order, AtlasTexture]

@export var speed_potion: Array[Ingredient]
@export var invis_potion: Array[Ingredient]
@export var fire_potion: Array[Ingredient]

func get_potion_texture(ingredients) -> AtlasTexture:
	var order_type := Order.ORANJE
	if Ingredient.Bot in ingredients:
		order_type = Order.ROOD
	elif Ingredient.Zout in ingredients:
		order_type = Order.GEEL
	
	return order_textures[order_type]
