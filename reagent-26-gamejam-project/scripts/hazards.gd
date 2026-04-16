extends Timer

const enums := preload("res://scripts/global_data.gd")
const globals := preload("res://scripts/global_data.tres")

var random_item: enums.Ingredient

func _on_timeout() -> void:
	
	if randi_range(0, 6) == 0:
		pass # police here
	else:
		random_item = enums.Ingredient.values().pick_random()
		$FallingItem.texture = globals.item_textures[random_item]
		%AnimationPlayer.play("falling_item")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$FallingItem.texture = null
	%Badkuip.add_ingredient(random_item)
	
	wait_time = randi_range(15, 60)
	start()
