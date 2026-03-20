extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Opponent.pokemon=GameManager.toBattle
	$Opponent.initialize()
	$Player.pokemon=GameManager.playerTeam[0]
	$Player.initialize()
	$BattleOptions/Display.text="What will " + str(GameManager.playerTeam[0].name) + " do?"

func _on_run_pressed() -> void:
	GameManager.toMain()


func _on_catch_pressed() -> void:
	if(len(GameManager.playerTeam)<=5):
		GameManager.playerTeam.append(GameManager.toBattle)
		get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_fight_pressed() -> void:
	$BattleOptions/Options.visible=false
	$BattleOptions/Moves.loadMoves(GameManager.playerTeam[0].moves)
