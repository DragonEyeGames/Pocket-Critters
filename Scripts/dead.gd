extends Control


func _on_retry_pressed() -> void:
	GameManager.playerPosition=Vector2.ZERO
	GameManager.playerTeam.clear()
	GameManager.pokedex.clear()
	GameManager.seenDex.clear()
	GameManager.restart()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
