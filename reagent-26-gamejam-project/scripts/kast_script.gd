extends StaticBody2D

const types = preload("res://scripts/global_data.gd")

var item_type: types.Ingredient
@export var item_texture: Texture2D

var opberg_type : types.Opberg
@export var opberg_texture: Texture2D

@export var item_offset: Vector2

func _ready():
	# dit fixt de kast met het lege glas
	$Item_Sprite.texture = item_texture
	$Kast_Sprite.texture = opberg_texture
	$Item_Sprite.position = item_offset

func update_vars():
	$Item_Sprite.texture = item_texture
	$Kast_Sprite.texture = opberg_texture
	match opberg_type:
		types.Opberg.KAST:
			item_offset = Vector2(0, -18)
		types.Opberg.TAFEL:
			item_offset = Vector2(0, -2)
		types.Opberg.KLEINKASTJE:
			item_offset = Vector2(0, -10)
	
	$Item_Sprite.position = item_offset
