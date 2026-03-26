extends Node2D

var playerEntered=false
@export var cityPath=""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.currentScene=get_tree().current_scene.scene_file_path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(playerEntered and Input.is_action_just_pressed("Interact")):
		GameManager.playerPosition=Vector2(160, -171)
		get_tree().call_deferred("change_scene_to_file", cityPath)


func _on_exit_area_entered(_area: Area2D) -> void:
	playerEntered=true

func _on_exit_area_exited(_area: Area2D) -> void:
	playerEntered=false
