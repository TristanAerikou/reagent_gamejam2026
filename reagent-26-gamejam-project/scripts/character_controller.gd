extends CharacterBody2D
class_name MainCharacter

const global_data = preload("res://scripts/global_data.tres")

@export var speed: int
@onready var raycast = $RayCast2D

var has_speed := false
var has_invis := false
var has_perfume := false

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
	
	
	if Input.is_action_just_pressed("drink"):
		drink()
	
	if not input_direction.is_zero_approx():
		raycast.target_position = input_direction * 16
		$HeldItem.position = input_direction * 8
	
	if Input.is_action_just_pressed("ui_select"):
		interact()
	
	move_and_slide()

func interact():
	var target = $RayCast2D.get_collider()
	if target == null: return
	
	if target is ItemPickup:
		$HeldItem.texture = target.get_texture()
		if target.has_meta("glas"):
			is_carrying = []
		else:
			is_carrying = target.item
			
	elif target is Badkuip:
		if is_carrying is Array and len(is_carrying) == 0:
			is_carrying = target.clear_badkuip()
			$HeldItem.texture = global_data.get_potion_texture(is_carrying)
		else:
			target.add_ingredient(is_carrying)
			is_carrying = null
			$HeldItem.texture = null
	
	elif target is WC:
		if is_carrying is Array:
			target.submit_potion(is_carrying)
		is_carrying = null
		$HeldItem.texture = null


func drink():
	if !(is_carrying is Array):
		return
	
	var matching_speed := true
	var matching_invis := true
	var matching_fire := true
	for type in global_data.Ingredient.values():
		if is_carrying.count(type) != global_data.speed_potion.count(type): matching_speed = false
		if is_carrying.count(type) != global_data.invis_potion.count(type): matching_invis = false
		if is_carrying.count(type) != global_data.fire_potion.count(type): matching_fire = false
	
	if matching_speed and !has_speed:
		speed *= 2
		has_speed = true
		var timer := Timer.new()
		timer.wait_time = 10
		timer.timeout.connect(func ():
			speed /= 2
			has_speed = false
			timer.queue_free()
		)
		add_child(timer)
		timer.start()
	
	elif matching_invis:
		$AnimatedSprite2D.modulate = Color(1, 1, 1, 0.2)
		has_invis = true
		var timer := Timer.new()
		timer.wait_time = 10
		timer.timeout.connect(func ():
			$AnimatedSprite2D.modulate = Color(1, 1, 1, 1)
			has_invis = false
			timer.queue_free()
		)
		add_child(timer)
		timer.start()
	
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
