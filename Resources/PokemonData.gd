extends Resource
class_name PokemonData

@export var name: String = ""
@export var base: SpeciesData
@export var species: GameManager.pokemon

@export var xp: int = 10
@export var level: int = 5
@export var maxHealth=10

#Stats
@export var health = 10
@export var attack = 10
@export var specialAttack = 10
@export var defense = 10
@export var specialDefense = 10
@export var speed = 10

#IV's
@export var ivHealth = 1
@export var ivAttack = 1
@export var ivSpecialAttack = 1
@export var ivDefense = 1
@export var ivSpecialDefense = 1
@export var ivSpeed = 1

#Moves
@export var moves: Array[MoveResource] = []
