extends Node

enum pokemon {
	Timberry, #Basic grass fox
	Howliage, #1
	Botanine, #2
	Pilfetch, #Basic flying bird
	Criminalis, #1
	Geckrow,#basic grass (ground) lizard
	Goanopy, #1
	Varanitor, #2
	Sligment, #Basic bug snal
	Viscolor, #1
	Gelescent, #2
	Pasturlo, #Basic grass ram thing
	Brambull, #1
	Maizotaur, #2
	Baoby, #Basic ground/grass
	Baobaraffe, #1
	Varmot, #Basic normal rat
	Merlicun, # Basic dragon bug caterpillar thing
	Firomenis, #1
	Pompet, # Basic grass fairy
	Pomprim, #1
	Saurky, #Basic water lizard
	Crestaka, #1
	Avipex, #2
	Dampurr, #basic water cat
	Rainther, #1
	Delugar, #2
	Bonfur, #Basic fire bear
	Tindursa, #1
	Sizzly, #2
	Lollybog, #Basic ghost poison
	Brewtrid, #1
	Forbiddron, #2
	Kankwart, #Basic poison rock
	Kankryst, #1
	Kankersaur, #2
	Baulder, #Basic rock dragon
	Dreadrock, #1
	Tekagon, #2
	Minamai, #Basic water fish thing
	Marelstorm, #1
	Dripwirt, #basic water thing?
	Pourka,
	Appalyp,#basic dark water thing
	Sycoral, #1
	Nemesusa, #2
	Sillennium # Basic priest (in moai)
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
	Priority,
	Accuracy
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

var canPause=true

var teamBattle=false
var opposingTeam: Array[PokemonData] = []

var attacking:="" 
var attackingID:=0

@export var encounterList: Array[pokemon] = []
@export var encounterMin: int
@export var encounterMax: int

@export var playerTeam: Array[PokemonData] = []
@export var healthyTeam: Array[PokemonData] = []

@export var playerPosition:= Vector2.ZERO
@export var respawnSpot:=Vector2.ZERO

@export var currentScene = "res://Levels/forest.tscn"

@export var blaze1:=false

@export var starter: TeamData

var camera: Camera2D

var healthMod=.6

var toBattle: PokemonData

var defeated=[]

var player

var transitionAnimator: AnimationPlayer

var evolvedSpecies
var evolutionSpecies

func _ready() -> void:
	if(not loadGame()):
		restart()
	else:
		SignalBus.emit_signal("loadData")
		await get_tree().process_frame
		get_tree().call_deferred("change_scene_to_file", currentScene)

func restart():
	starter=load("res://StarterPokemon/geckrowStarter.tres")
	playerTeam.append(setPokemon(starter.species, starter.level, starter.moves))
	pokedex.append(pokemon.Geckrow)
	seenDex.append(pokemon.Geckrow)


func wildBattle(newPokemonInstance):
	transitionAnimator.play("transition")
	await get_tree().create_timer(1.1).timeout
	canPause=true
	toBattle=newPokemonInstance
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/battle.tscn")
	
func trainerBattle(trainerName, pokemonList, ID):
	attackingID=ID
	attacking=trainerName
	toBattle=pokemonList[0]
	pokemonList.remove_at(0)
	opposingTeam=pokemonList.duplicate()
	teamBattle=true
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/battle.tscn")

func pokemonName(value):
	for n in GameManager.pokemon.keys():
		if GameManager.pokemon[n] == value:
			return n
	return "Unknown"

func newPokemon(species, level = 6):
	var p = PokemonData.new()
	p.base = load("res://Pokemon/" + pokemonName(species).to_lower() + ".tres")
	p.name = pokemonName(species)
	p.species=species
	p.level = level
	p.xp=get_xp_for_level(level)+1
	p.ivHealth=loadIV()
	p.ivSpeed=loadIV()
	p.ivAttack=loadIV()
	p.ivSpecialAttack=loadIV()
	p.ivDefense=loadIV()
	p.ivSpecialDefense=loadIV()
	p.health=int(get_stat(p.base.health, p.ivHealth, level)*healthMod)
	p.maxHealth=int(get_stat(p.base.health, p.ivHealth, level)*healthMod)
	p.attack=get_stat(p.base.attack, p.ivAttack, level)
	p.defense=get_stat(p.base.defense, p.ivDefense, level)
	p.specialAttack=get_stat(p.base.specialAttack, p.ivSpecialAttack, level)
	p.specialDefense=get_stat(p.base.specialDefense, p.ivSpecialDefense, level)
	p.speed=get_stat(p.base.speed, p.ivSpeed, level)
	var backupMoves = p.base.potentialMoves.duplicate()
	while len(backupMoves)>=1 and len(p.moves) < 4:
		var move = backupMoves.pick_random()
		if(move.level<=p.level):
			p.moves.append(move.move)
		backupMoves.erase(move)
	return p
	
func setPokemon(species, level, moves):
	var p = PokemonData.new()
	p.base = load("res://Pokemon/" + pokemonName(species).to_lower() + ".tres")
	p.name = pokemonName(species)
	p.species=species
	p.level = level
	p.xp=get_xp_for_level(level)+1
	p.ivHealth=loadIV()
	p.ivSpeed=loadIV()
	p.ivAttack=loadIV()
	p.ivSpecialAttack=loadIV()
	p.ivDefense=loadIV()
	p.ivSpecialDefense=loadIV()
	p.health=int(get_stat(p.base.health, p.ivHealth, level)*healthMod)
	p.maxHealth=int(get_stat(p.base.health, p.ivHealth, level)*healthMod)
	p.attack=get_stat(p.base.attack, p.ivAttack, level)
	p.defense=get_stat(p.base.defense, p.ivDefense, level)
	p.specialAttack=get_stat(p.base.specialAttack, p.ivSpecialAttack, level)
	p.specialDefense=get_stat(p.base.specialDefense, p.ivSpecialDefense, level)
	p.speed=get_stat(p.base.speed, p.ivSpeed, level)
	p.moves=moves
	return p
	
func evolvePokemon(original: PokemonData, evolution: SpeciesData):
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/evolve.tscn")
	Music.evolve()
	evolvedSpecies=original.species
	evolutionSpecies=evolution.species
	original.base=evolution
	original.species=evolution.species
	original.name = pokemonName(evolution.species)
	var backupHealth=original.maxHealth
	original.maxHealth=int(get_stat(evolution.health, original.ivHealth, original.level)*healthMod)
	original.health+=original.maxHealth-backupHealth
	original.attack=get_stat(evolution.attack, original.ivAttack, original.level)
	original.defense=get_stat(evolution.defense, original.ivDefense, original.level)
	original.specialAttack=get_stat(evolution.specialAttack, original.ivSpecialAttack, original.level)
	original.specialDefense=get_stat(evolution.specialDefense, original.ivSpecialDefense, original.level)
	original.speed=get_stat(evolution.speed, original.ivSpeed, original.level)
	
func get_stat(base: int, iv: float,  level: int) -> int:
	return int(base * (level / 10.0) * iv + 5)

func toMain():
	safe=true
	Music.battleEnded()
	get_tree().change_scene_to_file(currentScene)
	await get_tree().create_timer(.5).timeout
	if(teamBattle):
		teamBattle=false
		SignalBus.emit_signal("defeated", attackingID)
		attacking=""
		await get_tree().create_timer(1).timeout
		defeated.append(attackingID)
	safe=false
	
func loadIV():
	return randf_range(.9, 1.1)
	
func get_level_from_xp(xp: int) -> int:
	return int(pow(xp / 0.5, 1.0/3.0))
	
func get_xp_for_level(level: int) -> int:
	return int(pow(level, 3) * 0.5)

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
	return 1.0 / (1.0 + pokemon_level / 30.0)
	
func get_stage_multiplier(stage: int) -> float:
	if stage >= 0:
		return (2.0 + stage) / 2.0
	else:
		return 2.0 / (2.0 - stage)

func saveGame():
	var data = GameData.new()
	var teamResource = PlayerTeamData.new()
	teamResource.team = playerTeam.duplicate()
	data.team=teamResource
	data.playerPos=player.global_position
	data.safePos=respawnSpot
	data.pokedex=pokedex.duplicate()
	data.seenDex=seenDex.duplicate()
	data.defeated=defeated.duplicate()
	data.blaze1=blaze1
	data.scene=currentScene
	ResourceSaver.save(data, "user://save.tres")

func loadGame():
	if not FileAccess.file_exists("user://save.tres"):
		print("No save file found")
		return false
	
	var data = load("user://save.tres") as GameData
	
	playerTeam = data.team.team.duplicate()
	playerPosition = data.playerPos
	respawnSpot = data.safePos
	pokedex = data.pokedex.duplicate()
	seenDex = data.seenDex.duplicate()
	defeated = data.defeated.duplicate()
	blaze1=data.blaze1
	currentScene=data.scene
	return true
	
func wipeSave():
	if FileAccess.file_exists("user://save.tres"):
		DirAccess.remove_absolute("user://save.tres")
	playerTeam = []
	playerPosition = Vector2.ZERO
	respawnSpot = Vector2.ZERO
	pokedex = []
	seenDex = []
	defeated = []
	blaze1 = false
	get_tree().change_scene_to_file("res://Levels/forest.tscn")
	restart()
