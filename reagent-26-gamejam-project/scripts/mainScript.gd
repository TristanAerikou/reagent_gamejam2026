extends Node2D
class_name mainScript

enum Ingredient {ZOUT, BOT, GOUDVIS, KOEKJE, KAAS}
enum Opberg {KAST, TAFEL, KLEINKASTJE}

const kast_template = preload("res://scenes/kast.tscn")

@export var plaatsen: Array[Vector2i]
@export var opberg_textures: Dictionary[Opberg, AtlasTexture]
@export var item_textures: Dictionary[Ingredient, AtlasTexture]

func _ready() -> void:
	# BELANGRIJK:
	# Als we willen potions maken, gaan we moeten bijhouden welke items er effectief in het spel zitten.
	# Als je de code van plaatsOpbergRuimtes() doorleest, zie je dat er uit de originele lijst items worden verwijderd.
	# Fix: steek de gebruikte items in een lijst die ook globaal wordt bijgehouden.
	for p in plaatsen:
		
		# nieuwe kast aanmaken
		var nieuwe_kast = kast_template.instantiate()
		nieuwe_kast.position = p
		
		# random
		var opberg_type = randi_range(0, len(Opberg)-1)
		var item_type = randi_range(0, len(Ingredient)-1)
		
		# opbergruimte texture setten
		nieuwe_kast.opberg_type = opberg_type
		nieuwe_kast.opberg_texture = opberg_textures.get(opberg_type)
		
		# item texture setten
		nieuwe_kast.item_type = item_type
		nieuwe_kast.item_texture = item_textures.get(item_type)
		
		add_child(nieuwe_kast)
