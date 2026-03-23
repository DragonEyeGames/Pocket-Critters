extends Node2D

@export var pokemon: GameManager.pokemon

func initialize():
	for child in $Front.get_children():
		child.visible=false
	for child in $Front.get_children():
		child.visible=false
		if(child.name==str(GameManager.pokemonName(pokemon))):
			child.visible=true
