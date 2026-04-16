extends MarginContainer

signal timeout

const types = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

var ingredients: Array[types.Ingredient] = []

var total_time: float = 80
var time_left: float = 80

func _ready():
	for ingredient_count in randi_range(1, 4):
		var ingredient_type = types.Ingredient.values().pick_random()
		
		var ingredient := TextureRect.new()
		ingredient.texture = global_data.item_textures[ingredient_type]
		$Background/HBox/Ingredients.add_child(ingredient)
		
		ingredients.push_back(ingredient_type)

	%OrderImage.texture = global_data.get_potion_texture(ingredients)

func _process(delta: float) -> void:
	time_left -= delta
	%CountDown.value = time_left / total_time
	if time_left <= 0:
		timeout.emit("One star review!")
		queue_free()
