extends StaticBody2D

var item_type: mainScript.Ingredient
@export var item_texture: Texture2D

var opberg_type : mainScript.Opberg
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
		mainScript.Opberg.KAST:
			item_offset = Vector2(0, -18)
		mainScript.Opberg.TAFEL:
			item_offset = Vector2(0, -2)
		mainScript.Opberg.KLEINKASTJE:
			item_offset = Vector2(0, -10)
	
	$Item_Sprite.position = item_offset
