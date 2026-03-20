extends Node2D

@export var back:=false
@export var pokemon: PokemonData
@export var holder: StatBlock

# Called when the node enters the scene tree for the first time.
func initialize() -> void:
	for child in $Back.get_children():
		child.visible=false
	for child in $Front.get_children():
		child.visible=false
	if(back):
		for child in $Back.get_children():
			child.visible=false
			if(child.name==str(GameManager.pokemonName(pokemon.species))):
				child.visible=true
	elif(!back):
		for child in $Front.get_children():
			child.visible=false
			if(child.name==str(GameManager.pokemonName(pokemon.species))):
				child.visible=true
	
	if(holder!=null):
		holder.pokemonName=str(GameManager.pokemonName(pokemon.species))
		holder.level=pokemon.level
		holder.health=pokemon.health
		holder.maxHealth=pokemon.maxHealth
		holder.initialize()
