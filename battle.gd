extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Opponent.pokemon=GameManager.toBattle
	$Opponent.initialize()
	$Player.pokemon=GameManager.playerTeam[0]
	$Player.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_run_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
