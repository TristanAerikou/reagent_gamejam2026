extends Node

const types = preload("res://scripts/global_data.gd")
@onready var orders: HBoxContainer = $"../Camera2D/Orders"

func submit_potion(potion: Array[types.Ingredient]):
	for order in orders.get_children():
		var matching := true
		for item in types.Ingredient.values():
			print("comparign ", item)
			if potion.count(item) != order.ingredients.count(item):
				matching = false
				break
		
		if matching:
			order.queue_free()
			print("fulfilled order!")
