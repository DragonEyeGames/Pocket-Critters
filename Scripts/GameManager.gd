extends Node

enum pokemon {
	Timberry,
	Pilfetch,
	Geckrow,
	Sligment,
	Dunsparce,
	Pasturlo,
	Baoby,
	Varmot,
	Merlicun,
	Pompet,
	Saurky,
	Dampurr,
	Bonfur,
	Lollybog,
	Kankwart,
	Baulder
}

enum types {
	Fire,
	Grass,
	Water,
	Flying,
	Normal,
	Electric,
	Bug,
	Ghost,
	Psychic,
	Dark,
	Dragon,
	Fairy,
	Fighting,
	Ground,
	Ice,
	Poison,
	Rock,
	Steel
}

enum moveTypes {
	Special,
	Physical,
	Status
}

enum stats {
	Health,
	Attack,
	Defense,
	Speed,
	SpecialAttack,
	SpecialDefense,
	Priority
}

var type_chart = {
	"Normal": {
		"Normal": 1.0, "Fire": 1.0, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 1.0, "Fighting": 1.0, "Poison": 1.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 0.5, "Ghost": 0.0, "Dragon": 1.0, "Dark": 1.0, "Steel": 0.5, "Fairy": 1.0
	},
	"Fire": {
		"Normal": 1.0, "Fire": 0.5, "Water": 0.5, "Electric": 1.0, "Grass": 2.0, "Ice": 2.0, "Fighting": 1.0, "Poison": 1.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 1.0, "Bug": 2.0, "Rock": 0.5, "Ghost": 1.0, "Dragon": 0.5, "Dark": 1.0, "Steel": 2.0, "Fairy": 1.0
	},
	"Water": {
		"Normal": 1.0, "Fire": 2.0, "Water": 0.5, "Electric": 1.0, "Grass": 0.5, "Ice": 1.0, "Fighting": 1.0, "Poison": 1.0, "Ground": 2.0, "Flying": 1.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 2.0, "Ghost": 1.0, "Dragon": 0.5, "Dark": 1.0, "Steel": 1.0, "Fairy": 1.0
	},
	"Electric": {
		"Normal": 1.0, "Fire": 1.0, "Water": 2.0, "Electric": 0.5, "Grass": 0.5, "Ice": 1.0, "Fighting": 1.0, "Poison": 1.0, "Ground": 0.0, "Flying": 2.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 1.0, "Ghost": 1.0, "Dragon": 0.5, "Dark": 1.0, "Steel": 1.0, "Fairy": 1.0
	},
	"Grass": {
		"Normal": 1.0, "Fire": 0.5, "Water": 2.0, "Electric": 1.0, "Grass": 0.5, "Ice": 1.0, "Fighting": 1.0, "Poison": 0.5, "Ground": 2.0, "Flying": 0.5, "Psychic": 1.0, "Bug": 0.5, "Rock": 2.0, "Ghost": 1.0, "Dragon": 0.5, "Dark": 1.0, "Steel": 0.5, "Fairy": 1.0
	},
	"Ice": {
		"Normal": 1.0, "Fire": 0.5, "Water": 0.5, "Electric": 1.0, "Grass": 2.0, "Ice": 0.5, "Fighting": 1.0, "Poison": 1.0, "Ground": 2.0, "Flying": 2.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 1.0, "Ghost": 1.0, "Dragon": 2.0, "Dark": 1.0, "Steel": 0.5, "Fairy": 1.0
	},
	"Fighting": {
		"Normal": 2.0, "Fire": 1.0, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 2.0, "Fighting": 1.0, "Poison": 0.5, "Ground": 1.0, "Flying": 0.5, "Psychic": 0.5, "Bug": 0.5, "Rock": 2.0, "Ghost": 0.0, "Dragon": 1.0, "Dark": 2.0, "Steel": 2.0, "Fairy": 0.5
	},
	"Poison": {
		"Normal": 1.0, "Fire": 1.0, "Water": 1.0, "Electric": 1.0, "Grass": 2.0, "Ice": 1.0, "Fighting": 1.0, "Poison": 0.5, "Ground": 0.5, "Flying": 1.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 0.5, "Ghost": 0.5, "Dragon": 1.0, "Dark": 1.0, "Steel": 0.0, "Fairy": 2.0
	},
	"Ground": {
		"Normal": 1.0, "Fire": 2.0, "Water": 1.0, "Electric": 2.0, "Grass": 0.5, "Ice": 1.0, "Fighting": 1.0, "Poison": 2.0, "Ground": 1.0, "Flying": 0.0, "Psychic": 1.0, "Bug": 0.5, "Rock": 2.0, "Ghost": 1.0, "Dragon": 1.0, "Dark": 1.0, "Steel": 2.0, "Fairy": 1.0
	},
	"Flying": {
		"Normal": 1.0, "Fire": 1.0, "Water": 1.0, "Electric": 0.5, "Grass": 2.0, "Ice": 1.0, "Fighting": 2.0, "Poison": 1.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 1.0, "Bug": 2.0, "Rock": 0.5, "Ghost": 1.0, "Dragon": 1.0, "Dark": 1.0, "Steel": 0.5, "Fairy": 1.0
	},
	"Psychic": {
		"Normal": 1.0, "Fire": 1.0, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 1.0, "Fighting": 2.0, "Poison": 2.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 0.5, "Bug": 1.0, "Rock": 1.0, "Ghost": 1.0, "Dragon": 1.0, "Dark": 0.0, "Steel": 0.5, "Fairy": 1.0
	},
	"Bug": {
		"Normal": 1.0, "Fire": 0.5, "Water": 1.0, "Electric": 1.0, "Grass": 2.0, "Ice": 1.0, "Fighting": 0.5, "Poison": 0.5, "Ground": 1.0, "Flying": 0.5, "Psychic": 2.0, "Bug": 1.0, "Rock": 1.0, "Ghost": 0.5, "Dragon": 1.0, "Dark": 2.0, "Steel": 0.5, "Fairy": 0.5
	},
	"Rock": {
		"Normal": 1.0, "Fire": 2.0, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 2.0, "Fighting": 0.5, "Poison": 1.0, "Ground": 0.5, "Flying": 2.0, "Psychic": 1.0, "Bug": 2.0, "Rock": 1.0, "Ghost": 1.0, "Dragon": 1.0, "Dark": 1.0, "Steel": 0.5, "Fairy": 1.0
	},
	"Ghost": {
		"Normal": 0.0, "Fire": 1.0, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 1.0, "Fighting": 1.0, "Poison": 1.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 2.0, "Bug": 1.0, "Rock": 1.0, "Ghost": 2.0, "Dragon": 1.0, "Dark": 0.5, "Steel": 1.0, "Fairy": 1.0
	},
	"Dragon": {
		"Normal": 1.0, "Fire": 1.0, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 1.0, "Fighting": 1.0, "Poison": 1.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 1.0, "Ghost": 1.0, "Dragon": 2.0, "Dark": 1.0, "Steel": 0.5, "Fairy": 0.0
	},
	"Dark": {
		"Normal": 1.0, "Fire": 1.0, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 1.0, "Fighting": 0.5, "Poison": 1.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 2.0, "Bug": 1.0, "Rock": 1.0, "Ghost": 2.0, "Dragon": 1.0, "Dark": 0.5, "Steel": 1.0, "Fairy": 0.5
	},
	"Steel": {
		"Normal": 1.0, "Fire": 0.5, "Water": 0.5, "Electric": 0.5, "Grass": 1.0, "Ice": 2.0, "Fighting": 1.0, "Poison": 1.0, "Ground": 1.0, "Flying": 1.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 2.0, "Ghost": 1.0, "Dragon": 1.0, "Dark": 1.0, "Steel": 0.5, "Fairy": 2.0
	},
	"Fairy": {
		"Normal": 1.0, "Fire": 0.5, "Water": 1.0, "Electric": 1.0, "Grass": 1.0, "Ice": 1.0, "Fighting": 2.0, "Poison": 0.5, "Ground": 1.0, "Flying": 1.0, "Psychic": 1.0, "Bug": 1.0, "Rock": 1.0, "Ghost": 1.0, "Dragon": 2.0, "Dark": 2.0, "Steel": 0.5, "Fairy": 1.0
	}
}

var pokedex : Array[pokemon] = []
var seenDex : Array[pokemon] = []

#a safe time before pokemon can spawn
var safe=false

@export var encounterList: Array[pokemon] = []
@export var encounterMin: int
@export var encounterMax: int

@export var playerTeam: Array[PokemonData] = []
@export var healthyTeam: Array[PokemonData] = []

@export var playerPosition:= Vector2.ZERO

var toBattle: PokemonData

func _ready() -> void:
	restart()

func restart():
	playerTeam.append(newPokemon(pokemon.Geckrow))
	pokedex.append(pokemon.Geckrow)


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
	while len(backupMoves)>=1 and len(p.moves) < 4:
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

func get_type_multiplier(moveType: String, defenderType1: String, defenderType2: String) -> float:
	var multiplier = 1.0
	
	multiplier *= type_chart[moveType][defenderType1]
	if(defenderType2!=defenderType1):
		multiplier *= type_chart[moveType][defenderType2]
	
	return multiplier
	
func get_catch_chance(newPokemon2, ball_multiplier: float) -> float:
	var max_hp = newPokemon2.maxHealth
	var current_hp = newPokemon2.health
	var catch_rate = newPokemon2.base.catchRate
	
	var hp_factor = (max_hp - current_hp) / max_hp
	var level_modifier = get_level_modifier(newPokemon2.level)
	
	var chance = catch_rate * ball_multiplier * (1.0 + hp_factor) * level_modifier
	
	return clamp(chance, 0.0, 1.0)

func get_level_modifier(pokemon_level: int) -> float:
	return 1.0 / (1.0 + pokemon_level / 20.0)
