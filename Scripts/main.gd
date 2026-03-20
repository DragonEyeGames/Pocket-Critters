extends Node2D

@export var pokemonEncounters: Array[GameManager.pokemon] = []
@export var levelMin: int
@export var levelMax: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.encounterList=pokemonEncounters
	GameManager.encounterMin=levelMin
	GameManager.encounterMax=levelMax
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
