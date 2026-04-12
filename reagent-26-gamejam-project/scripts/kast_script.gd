extends StaticBody2D

var item_type: mainScript.Ingredient
var item_texture: Texture2D

var opberg_type : mainScript.Opberg
var opberg_texture: Texture2D

func _ready() -> void:
	
	match opberg_type:
		mainScript.Opberg.KAST:
			pass
		mainScript.Opberg.TAFEL:
			$Item_Sprite.position = Vector2(0, 0)
		mainScript.Opberg.KLEINKASTJE:
			$Item_Sprite.position = Vector2(0, -8)
	
	$Item_Sprite.texture = item_texture
	$Kast_Sprite.texture = opberg_texture
