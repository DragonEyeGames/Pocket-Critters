extends Control


func _on_retry_pressed() -> void:
	GameManager.playerPosition=Vector2.ZERO
	for pokemon in GameManager.playerTeam:
		pokemon.health=pokemon.maxHealth
	get_tree().change_scene_to_file("res://Levels/forest-1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
