extends Node2D
class_name mainScript

enum Ingredient {ZOUT, BOT, GOUDVIS, KOEKJE, KAAS}
enum Opberg {KAST, TAFEL, KLEINKASTJE}

@onready var plaatsen = [
	Vector2i(112, -48),
	Vector2i(80, -48),
	Vector2i(48, -48),
	]
@onready var opberg_textures = [
	[Opberg.KAST, $Item_Opberg/Textures/Kast], 
	[Opberg.TAFEL, $Item_Opberg/Textures/Tafel],
	[Opberg.KLEINKASTJE, $Item_Opberg/Textures/KleinKastje]
]
@onready var item_textures = [
	$Item_Opberg/Items/Zout,
	$Item_Opberg/Items/Bot,
	$Item_Opberg/Items/Goudvis,
	$Item_Opberg/Items/Koekje,
	$Item_Opberg/Items/Kaas
]

func _ready() -> void:
	# BELANGRIJK:
	# Als we willen potions maken, gaan we moeten bijhouden welke items er effectief in het spel zitten.
	# Als je de code van plaatsOpbergRuimtes() doorleest, zie je dat er uit de originele lijst items worden verwijderd.
	# Fix: steek de gebruikte items in een lijst die ook globaal wordt bijgehouden.
	
	randomize()
	plaatsOpbergRuimtes(plaatsen, opberg_textures, item_textures)
		
func plaatsOpbergRuimtes(posities : Array, opbergTextures : Array, itemTextures : Array) -> void:
	for p in posities:
		# random
		var opbergType = randi_range(0, opbergTextures.size()-1)
		var itemType = randi_range(0, itemTextures.size()-1)
		
		# nieuwe kast aanmaken
		var nieuweKast = $KastTemplate.duplicate()
		nieuweKast.position = p
		
		# opbergruimte texture setten
		nieuweKast.opberg_type = opbergTextures[opbergType][0]
		nieuweKast.opberg_texture = opbergTextures[opbergType][1].texture
		nieuweKast.opberg_texture_rect = opbergTextures[opbergType][1].region_rect
		
		# item texture setten
		nieuweKast.item_texture = itemTextures[itemType].texture
		nieuweKast.item_texture_rect = itemTextures[itemType].region_rect
		
		itemTextures.remove_at(itemType)
		add_child(nieuweKast)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass
