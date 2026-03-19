extends Node

enum pokemon {
	Timberry,
	Frirate,
	Geckrow
}

enum types {
	Fire,
	Grass,
	Water,
	Flying
}

@export var encounterList: Array[pokemon] = []

@export var playerTeam: Array[PokemonData] = []

@export var playerPosition: Vector2

var toBattle: pokemon

func _ready():
	var p = PokemonData.new()
	p.species = preload("res://Pokemon/geckrow.tres")
	p.name = "Geckrow"
	p.level = 5
	p.moves = [
		preload("res://Moves/leafSlice.tres")
	]

func wildBattle(newPokemon):
	toBattle=newPokemon
	get_tree().call_deferred("change_scene_to_file", "res://battle.tscn")

func pokemonName(value):
	for n in GameManager.pokemon.keys():
		if GameManager.pokemon[n] == value:
			return n
	return "Unknown"
