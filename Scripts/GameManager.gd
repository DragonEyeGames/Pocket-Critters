extends Node

enum pokemon {
	Timberry,
	Pilfetch,
	Geckrow
}

enum types {
	Fire,
	Grass,
	Water,
	Flying,
	Normal,
	Electric
}

enum moveTypes {
	Special,
	Physical
}

@export var encounterList: Array[pokemon] = []

@export var playerTeam: Array[PokemonData] = []

@export var playerPosition: Vector2

var toBattle: PokemonData

func _ready():
	playerTeam.append(newPokemon(pokemon.Geckrow))

func wildBattle(newPokemonInstance):
	toBattle=newPokemonInstance
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/battle.tscn")

func pokemonName(value):
	for n in GameManager.pokemon.keys():
		if GameManager.pokemon[n] == value:
			return n
	return "Unknown"

func newPokemon(species, health = null, level = 5):
	var p = PokemonData.new()
	p.base = load("res://Pokemon/" + pokemonName(species).to_lower() + ".tres")
	p.name = pokemonName(species)
	p.species=species
	p.level = level
	p.ivHealth=randf_range(.8, 1.2)
	p.ivSpeed=randf_range(.8, 1.2)
	p.ivAttack=randf_range(.8, 1.2)
	p.ivSpecialAttack=randf_range(.8, 1.2)
	p.ivDefense=randf_range(.8, 1.2)
	p.ivSpecialDefense=randf_range(.8, 1.2)
	if(health==null):
		health=get_stat(p.base.health, p.ivHealth, level)
	p.health=health
	p.maxHealth=get_stat(p.base.health, p.ivHealth, level)
	p.attack=get_stat(p.base.attack, p.ivAttack, level)
	p.defense=get_stat(p.base.defense, p.ivDefense, level)
	p.specialAttack=get_stat(p.base.specialAttack, p.ivSpecialAttack, level)
	p.specialDefense=get_stat(p.base.specialDefense, p.ivSpecialDefense, level)
	p.speed=get_stat(p.base.speed, p.ivSpeed, level)
	p.moves.append(preload("res://Moves/leafSlice.tres"))
	return p
	
func get_stat(base: int, iv: float,  level: int) -> int:
	return int(base * (level / 10.0) * iv + 5)
