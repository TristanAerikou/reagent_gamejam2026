extends StaticBody2D

const types = preload("res://scripts/global_data.gd")
const global_data = preload("res://scripts/global_data.tres")

var ingredients: Array[types.Ingredient] = []

func add_ingredient(ingredient: types.Ingredient):
	ingredients.push_back(ingredient)
