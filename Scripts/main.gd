extends Node2D

@export var pokemonEncounters: Array[GameManager.pokemon] = []
@export var levelMin: int
@export var levelMax: int
@export var pokemonCenter: String
var pokeCenterEntered=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.currentScene=get_tree().current_scene.scene_file_path
	GameManager.encounterList=pokemonEncounters
	GameManager.encounterMin=levelMin
	GameManager.encounterMax=levelMax
	GameManager.transitionAnimator=$Transition/AnimationPlayer
	#pass

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") and pokeCenterEntered):
		get_tree().call_deferred("change_scene_to_file", pokemonCenter)

func _on_exit_area_entered(_area: Area2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/victory.tscn")


func _on_poke_center_area_entered(_area: Area2D) -> void:
	pokeCenterEntered=true
