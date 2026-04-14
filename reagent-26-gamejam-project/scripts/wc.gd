extends Node

const types = preload("res://scripts/global_data.gd")

func submit_potion(potion: Array[types.Ingredient]):
	print("drankje ingediend", potion)
