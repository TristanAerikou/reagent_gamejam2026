extends Timer

signal cop_looking
signal cop_leaving

const enums := preload("res://scripts/global_data.gd")
const globals := preload("res://scripts/global_data.tres")

var random_item: enums.Ingredient

func _on_timeout() -> void:
	
	if randi_range(0, 4) == 0:
		$Cop.animation = "walk_up"
		%AnimationPlayer.play("cop_move_up")
	else:
		random_item = enums.Ingredient.values().pick_random()
		$FallingItem.texture = globals.item_textures[random_item]
		%AnimationPlayer.play("falling_item")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "falling_item":
		$FallingItem.texture = null
		%Badkuip.add_ingredient(random_item)
		wait_time = randi_range(10, 30)
		start()
	
	elif anim_name == "cop_move_up":
		cop_looking.emit()
		$Cop.animation = "look"
		get_tree().create_timer(5).timeout.connect(func ():
			_on_animation_player_animation_finished("cop_look")
		)
	
	elif anim_name == "cop_look":
		cop_leaving.emit()
		$Cop.animation = "walk_down"
		%AnimationPlayer.play("cop_move_down")
	
	elif anim_name == "cop_move_down":
		wait_time = randi_range(10, 30)
		start()
