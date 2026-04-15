extends CharacterBody2D

const types = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

@export var speed: int
@onready var raycast = $RayCast2D

# bevat exact wat je vast hebt en heeft dus geen type
# null -> lege handen
# Ingredient -> een enkel ingredient
# lege array -> leeg glas
# Array[Ingredient] -> glas met potion in
var is_carrying

func _process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed * delta
	change_sprite(input_direction)
	
	interact()
	
	if not input_direction.is_zero_approx():
		raycast.target_position = input_direction * 16
		$HeldItem.position = input_direction * 8
	
	move_and_slide()

func interact():
	var target = raycast.get_collider()
	if target == null:
		$Control.visible = false
		return
	
	if Input.is_action_just_pressed("ui_select") and target.has_meta("is_glas_kast"):
		# kast met leeg glas
		$HeldItem.texture = target.item_texture
		is_carrying = []
		
	elif "item_type" in target:
		# kast met ingredient
		$Control.visible = true
		$Control/Label.text = "Press E to\nPick up object"
		if Input.is_action_just_pressed("ui_select"):
			$HeldItem.texture = target.item_texture
			is_carrying = target.item_type
		
	elif target.has_method("add_ingredient"):
		# badkuip
		$Control.visible = true
		$Control/Label.text = "Press E to\nDrop off object"
		
		if Input.is_action_just_pressed("ui_select"):
			if is_carrying is Array and len(is_carrying) == 0:
				# leeg glas
				is_carrying = target.clear_badkuip()
				$HeldItem.texture = global_data.get_potion_texture(is_carrying)
				
			elif is_carrying != null:
				target.add_ingredient(is_carrying)
				is_carrying = null
				$HeldItem.texture = null
	
	elif Input.is_action_just_pressed("ui_select") and target.has_method("submit_potion"):
		# wc
		if is_carrying is Array[types.Ingredient]:
			target.submit_potion(is_carrying)
		
		# gooi zowiezo item in uw hand weg, dus ingredienten en leeg glas kan je weggooien zonder indienen
		is_carrying = null
		$HeldItem.texture = null
		
	else:
		$Control.visible = false

func change_sprite(direction):
	var walking_left = Vector2(-1.0, 0.0)
	var walking_right = Vector2(1.0, 0.0)
	var walking_up = Vector2(0.0, -1.0)
	var walking_down = Vector2(0.0, 1.0)
	var idle = Vector2(0.0, 0.0)
	match direction:
		idle:
			match $AnimatedSprite2D.animation:
				"player_walking_left":
					$AnimatedSprite2D.animation = "player_idle_left"
				"player_walking_right":
					$AnimatedSprite2D.animation = "player_idle_right"
				"player_walking_up":
					$AnimatedSprite2D.animation = "player_idle_up"
				"player_walking_down":
					$AnimatedSprite2D.animation = "player_idle_down"
		walking_left:
			$AnimatedSprite2D.animation = "player_walking_left"
		walking_right:
			$AnimatedSprite2D.animation = "player_walking_right"
		walking_up:
			$AnimatedSprite2D.animation = "player_walking_up"
		walking_down:
			$AnimatedSprite2D.animation = "player_walking_down"
