extends Node2D

@export var pokemon: GameManager.pokemon

func initialize():
	$Pokemon.texture=load("res://Fakemon-PNG/" + str(GameManager.pokemonName(pokemon)).to_lower() + ".png")
