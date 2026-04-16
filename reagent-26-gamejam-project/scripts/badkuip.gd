extends Area2D
class_name Badkuip

signal on_fire
signal extinguished

const enums = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

@export var leeg_texture: AtlasTexture
@export var vol_texture: AtlasTexture

var ingredients: Array[enums.Ingredient] = []

func _on_body_entered(body: Node2D):
	%BadItemBackground.visible = true
	
func _on_body_exited(body: Node2D):
	%BadItemBackground.visible = false

func add_ingredient(ingredient: enums.Ingredient):
	
	var offset := Vector2(0, 0)
	match ingredient:
		enums.Ingredient.Water:
			offset = Vector2(48, 0)
			$Fire.emitting = false
			extinguished.emit()
		
		enums.Ingredient.Zout:
			offset = Vector2(0, -24)
			if ingredients.has(enums.Ingredient.Batterij) and !ingredients.has(enums.Ingredient.Water):
				$Explosion.play("explode")
				$Fire.emitting = true
				on_fire.emit()
		
		enums.Ingredient.Batterij:
			if ingredients.has(enums.Ingredient.Zout) and !ingredients.has(enums.Ingredient.Water):
				$Explosion.play("explode")
				$Fire.emitting = true
				on_fire.emit()
		
		enums.Ingredient.Bot:
			offset = Vector2(0, -48)
		
			
	if !(ingredients.has(ingredient)):
		($BadkuipSprite.texture as AtlasTexture).region.position += offset
	
	ingredients.push_back(ingredient)
	var tex := TextureRect.new()
	tex.texture = global_data.item_textures[ingredient]
	%BadItems.add_child(tex)

func clear_badkuip() -> Array[enums.Ingredient]:
	var copy := ingredients.duplicate()
	ingredients.clear()
	for child in %BadItems.get_children():
		child.queue_free()
	($BadkuipSprite.texture as AtlasTexture).region.position = Vector2(0, 72)
	return copy
