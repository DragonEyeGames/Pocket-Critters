extends Resource
class_name SpeciesData

@export var species: GameManager.pokemon
@export var type1: GameManager.types
@export var type2: GameManager.types
@export var health = 10
@export var attack = 10
@export var defense = 10
@export var specialAttack = 10
@export var specialDefense = 10
@export var speed = 10
@export var potentialMoves: Array[MoveResource]

@export var catchRate:= 0.0

@export var cryPath: String

@export var evolution: EvolutionData
@export var prevolution: GameManager.pokemon
