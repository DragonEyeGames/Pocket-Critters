extends Node2D

@export var travelZone = ""
@export var travelPos = Vector2.ZERO


func _on_area_entered(_area: Area2D) -> void:
	GameManager.playerPosition=travelPos
	get_tree().call_deferred("change_scene_to_file", travelZone)
