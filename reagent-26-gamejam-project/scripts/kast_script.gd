extends StaticBody2D

@export var item_type: mainScript.Ingredient
@export var item_texture: Texture2D
@export var item_texture_rect : Rect2

@export var opberg_type : mainScript.Opberg
@export var opberg_texture: Texture2D
@export var opberg_texture_rect : Rect2

func _ready() -> void:
	
	match opberg_type:
		mainScript.Opberg.KAST:
			pass
		mainScript.Opberg.TAFEL:
			$Item_Sprite.position = Vector2(0, 0)
		mainScript.Opberg.KLEINKASTJE:
			$Item_Sprite.position = Vector2(0, -8)
	
	
	
	$Item_Sprite.texture = item_texture
	$Item_Sprite.region_enabled = true
	$Item_Sprite.region_rect = item_texture_rect
	
	$Kast_Sprite.texture = opberg_texture
	$Kast_Sprite.region_enabled = true
	$Kast_Sprite.region_rect = opberg_texture_rect
