extends Area2D
class_name WC

const enums = preload("res://scripts/global_data.gd")

var score: int = 0

func submit_potion(potion: Array[enums.Ingredient]):
	print("submitted ", potion)
	for order in %Orders.get_children():
		var matching := true
		for item in enums.Ingredient.values():
			if potion.count(item) != order.ingredients.count(item):
				matching = false
				break
		
		if matching:
			order.queue_free()
			score += 10
			%ScoreLabel.text = "Score: " + str(score)
			break
