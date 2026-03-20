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

#a safe time before pokemon can spawn
var safe=false

@export var encounterList: Array[pokemon] = []
@export var encounterMin: int
@export var encounterMax: int

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

func newPokemon(species, level = 5):
	var p = PokemonData.new()
	p.base = load("res://Pokemon/" + pokemonName(species).to_lower() + ".tres")
	p.name = pokemonName(species)
	p.species=species
	p.level = level
	p.xp=get_xp_for_level(level)
	p.ivHealth=loadIV()
	p.ivSpeed=loadIV()
	p.ivAttack=loadIV()
	p.ivSpecialAttack=loadIV()
	p.ivDefense=loadIV()
	p.ivSpecialDefense=loadIV()
	p.health=get_stat(p.base.health, p.ivHealth, level)
	p.maxHealth=get_stat(p.base.health, p.ivHealth, level)
	p.attack=get_stat(p.base.attack, p.ivAttack, level)
	p.defense=get_stat(p.base.defense, p.ivDefense, level)
	p.specialAttack=get_stat(p.base.specialAttack, p.ivSpecialAttack, level)
	p.specialDefense=get_stat(p.base.specialDefense, p.ivSpecialDefense, level)
	p.speed=get_stat(p.base.speed, p.ivSpeed, level)
	var backupMoves = p.base.potentialMoves.duplicate()
	while len(backupMoves)>=1:
		var move = backupMoves.pick_random()
		p.moves.append(move)
		backupMoves.erase(move)
	return p
	
func get_stat(base: int, iv: float,  level: int) -> int:
	return int(base * (level / 10.0) * iv + 5)

func toMain():
	safe=true
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	await get_tree().create_timer(.5).timeout
	safe=false
	
func loadIV():
	return randf_range(.9, 1.1)
	
func get_level_from_xp(xp: int) -> int:
	return int(pow(xp, 1.0/3.0))
	
func get_xp_for_level(level: int) -> int:
	return int(pow(level, 3))
