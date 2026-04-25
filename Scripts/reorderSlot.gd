extends Control

@export var index:= 0
@export var bigBoss: Node

func _ready() -> void:
	initialize()

func initialize():
	if(len(GameManager.playerTeam)-1>=index):
		visible=true
		var pokemon: PokemonData = GameManager.playerTeam[index]
		$NewPokemon.pokemon=pokemon.species
		$NewPokemon.initialize()
		$Name.text=pokemon.name
		$"Health Bar".value=pokemon.health
		$"Health Bar".max_value=pokemon.maxHealth
		$"Health Bar/Health".text=str(pokemon.health) + "/" + str(pokemon.maxHealth)
		prints(index, bigBoss.activeIndex)
		$Button.disabled=(pokemon.health<=0 or bigBoss.activeIndex==index)
		$Fainted.visible=pokemon.health<=0
	else:
		visible=false


func _on_select_pressed() -> void:
	bigBoss.swapPokemon(index)
