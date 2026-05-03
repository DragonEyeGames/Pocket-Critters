extends Control


func _on_reveal_animation_finished(_anim_name: StringName) -> void:
	await $Transitioner.darkenScreen()
	get_tree().change_scene_to_file("res://Scenes/mainMenu.tscn")
	
