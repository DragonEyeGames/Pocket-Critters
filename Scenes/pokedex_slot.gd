extends Control

@export var pokemon: GameManager.pokemon

func initialize():
	$Pokemon.pokemon=pokemon
	$Pokemon.initialize()
	if(pokemon in GameManager.pokedex):
		$Pokemon.modulate=Color.WHITE
	elif(pokemon in GameManager.seenDex):
		$Pokemon.modulate=Color.DIM_GRAY
	else:
		$Pokemon.modulate=Color.BLACK
