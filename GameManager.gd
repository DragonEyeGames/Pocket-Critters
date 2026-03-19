extends Node

enum pokemon {
	Timberry,
	Frirate,
	Geckrow
}

@export var encounterList: Array[pokemon] = []

@export var playerTeam: Array[pokemon] = [pokemon.Geckrow]

@export var playerPosition: Vector2

var toBattle: pokemon

func wildBattle(newPokemon):
	toBattle=newPokemon
	get_tree().call_deferred("change_scene_to_file", "res://battle.tscn")
