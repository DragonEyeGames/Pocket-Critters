extends Node2D

@export var travelZone = ""
@export var travelPos = Vector2.ZERO


func _on_area_entered(area: Area2D) -> void:
	area.get_parent().canMove=false
	GameManager.playerPosition=travelPos
	await $"../Transitioner".darkenScreen()
	print(travelZone)
	get_tree().call_deferred("change_scene_to_file", travelZone)
