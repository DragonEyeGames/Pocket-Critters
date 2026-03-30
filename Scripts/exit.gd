extends Node2D

@export var travelZone = ""
@export var travelPos = Vector2.ZERO
@export var locked:=false
var playerEntered=false
var player
@export var transitioner: CanvasLayer

func _on_area_entered(area: Area2D) -> void:
	if(locked):
		player=area
		playerEntered=true
		return
	area.get_parent().canMove=false
	GameManager.playerPosition=travelPos
	await transitioner.darkenScreen()
	print(travelZone)
	get_tree().call_deferred("change_scene_to_file", travelZone)


func _on_area_2d_area_exited(_area: Area2D) -> void:
	if(locked):
		playerEntered=false
		locked=false
		
func _process(_delta: float) -> void:
	if(locked and playerEntered and Input.is_action_just_pressed("Interact")):
		locked=false
		_on_area_entered(player)
