extends StaticBody2D

@export var item_type: mainScript.Ingredient
@export var item: Texture2D

func _ready() -> void:
	$Item_Sprite.texture = item
