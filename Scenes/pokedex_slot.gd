extends Control

@export var pokemon: GameManager.pokemon

func initialize():
	$Pokemon.pokemon=pokemon
	$Pokemon.initialize()
	if(pokemon in GameManager.pokedex):
		$Pokemon.modulate=Color.WHITE
	else:
		$Pokemon.modulate=Color.BLACK
