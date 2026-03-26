extends Node2D

@export var back:=false
@export var pokemon: GameManager.pokemon
var backupPokemon=null

# Called when the node enters the scene tree for the first time.
func initialize() -> void:
	for child in $Back.get_children():
		child.visible=false
	for child in $Front.get_children():
		child.visible=false
	if(back):
		for child in $Back.get_children():
			child.visible=false
			if(child.name==str(GameManager.pokemonName(pokemon))):
				child.visible=true
	elif(!back):
		for child in $Front.get_children():
			child.visible=false
			if(child.name==str(GameManager.pokemonName(pokemon))):
				child.visible=true
