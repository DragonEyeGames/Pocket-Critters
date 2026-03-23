extends Node2D

@export var pokemonEncounters: Array[GameManager.pokemon] = []
@export var levelMin: int
@export var levelMax: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.encounterList=pokemonEncounters
	GameManager.encounterMin=levelMin
	GameManager.encounterMax=levelMax
	GameManager.transitionAnimator=$Transition/AnimationPlayer
	#pass


func _on_exit_area_entered(_area: Area2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/victory.tscn")
