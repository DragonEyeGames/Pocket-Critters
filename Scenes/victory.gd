extends Control



func _on_explore_pressed() -> void:
	GameManager.toMain()


func _on_restart_pressed() -> void:
	GameManager.wipeSave()
