extends Node2D

@onready var sprite = $Sprite
@export var randomness = 0.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_area_2d_area_entered(area: Area2D) -> void:
	$Rustle.pitch_scale=randf_range(.9, 1.1)
	$Rustle.play()
	if(GameManager.safe):
		return
	if(randf() <= randomness):
		Music.battle()
		GameManager.canPause=false
		area.get_parent().canMove=false
		GameManager.playerPosition=area.get_parent().global_position
		var picked_value = GameManager.encounterList.pick_random()
		GameManager.wildBattle(GameManager.newPokemon(picked_value, randi_range(GameManager.encounterMin, GameManager.encounterMax)))
		return
	if(area.get_parent().global_position.y<=global_position.y):
		sprite.position.y+=1
		await get_tree().create_timer(0).timeout
		await get_tree().create_timer(0).timeout
		sprite.position.y-=1
	elif(area.get_parent().global_position.y>global_position.y):
		sprite.position.y-=1
		await get_tree().create_timer(0).timeout
		await get_tree().create_timer(0).timeout
		sprite.position.y+=1
