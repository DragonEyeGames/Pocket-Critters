extends Node2D

@export var back:=false
@export var pokemon: PokemonData
@export var holder: StatBlock

@export var attack=0
@export var defense=0
@export var specialAttack=0
@export var specialDefense=0
@export var speed=0

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
		if(pokemon.health<=0):
			visible=false
			holder.health=0
			pokemon.health=0
		holder.initialize()
			
func randomAttack():
	return(pokemon.moves.pick_random())
