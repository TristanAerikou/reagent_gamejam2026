extends StaticBody2D

enum ReceptEnum { FAIL, SPEED, ORDER }

# Dictionary[ReceptEnum, Array[mainScript.Ingredient]]
var recepten

var ingredients: Array[mainScript.Ingredient] = []

func add_ingredient(ingredient: mainScript.Ingredient):
	ingredients.push_back(ingredient)
	print(ingredients)
