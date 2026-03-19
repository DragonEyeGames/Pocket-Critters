extends Node2D

@onready var sprite = $Sprite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent().global_position.y<=global_position.y):
		sprite.position.y+=1
		await get_tree().process_frame
		await get_tree().process_frame
		sprite.position.y-=1
	elif(area.get_parent().global_position.y>global_position.y):
		sprite.position.y-=1
		await get_tree().process_frame
		await get_tree().process_frame
		sprite.position.y+=1
