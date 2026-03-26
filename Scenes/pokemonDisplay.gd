extends Node2D

@export var pokemon: GameManager.pokemon

# Called when the node enters the scene tree for the first time.
func initialize() -> void:
	for child in get_children():
		child.visible=false
		if(child.name==str(GameManager.pokemonName(pokemon))):
			child.visible=true
