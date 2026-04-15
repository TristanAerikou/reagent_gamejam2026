extends Resource
class_name TextureMap

enum Ingredient { ZOUT, BOT, GOUDVIS, KOEKJE, KAAS }
enum Opberg { KAST, TAFEL, KLEINKASTJE }
enum Order { ROOD, GEEL, ORANJE }

@export var opberg_textures: Dictionary[Opberg, AtlasTexture]
@export var item_textures: Dictionary[Ingredient, AtlasTexture]
@export var order_textures: Dictionary[Order, AtlasTexture]

func get_potion_texture(ingredients) -> AtlasTexture:
	var order_type := Order.ORANJE
	if Ingredient.ZOUT in ingredients:
		order_type = Order.GEEL
	elif Ingredient.BOT in ingredients:
		order_type = Order.ROOD
	elif Ingredient.KAAS in ingredients:
		order_type = Order.GEEL
	
	return order_textures[order_type]
