extends Control

func _ready():
	Music.battleEnded()
	await get_tree().create_timer(1).timeout
	$resolution.visible=true
	await get_tree().create_timer(1.5).timeout
	$Continue.visible=true

func _on_retry_pressed() -> void:
	GameManager.playerPosition=GameManager.respawnSpot
	for pokemon in GameManager.playerTeam:
		pokemon.health=pokemon.maxHealth
	get_tree().change_scene_to_file(GameManager.respawnScene)


func _on_quit_pressed() -> void:
	get_tree().quit()
