extends Resource
class_name GameData

@export var team: PlayerTeamData
@export var playerBoxes: Array[PokemonData] = []
@export var playerPos: Vector2
@export var safePos: Vector2
@export var defeated: =[]
@export var pokedex: Array[GameManager.pokemon]
@export var seenDex: Array[GameManager.pokemon]
@export var scene :=""
@export var playtime:=0.0
@export var playerName:=""
#Rival Battles
@export var blaze1:=false
