extends CharacterBody2D

@export var speed = 75
@onready var raycast = $RayCast2D

var is_carrying

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	change_sprite(input_direction)
	
	if not input_direction.is_zero_approx():
		raycast.target_position = input_direction * 16
		$HeldItem.position = input_direction * 8
		
	if Input.is_action_just_pressed("ui_select"):
		var target = raycast.get_collider()
		if target != null:
			if "item_type" in target:
				$HeldItem.texture = target.item_texture
				is_carrying = target.item_type
			elif "add_ingredient" in target:
				target.add_ingredient(is_carrying)
				is_carrying = null
				$HeldItem.texture = null

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

func _physics_process(_delta):
	get_input()
	move_and_slide()
