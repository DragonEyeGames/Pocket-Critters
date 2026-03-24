extends Node2D

var ID: int = 0

var sprite
@export var dialogue: CanvasLayer

var speechPage=0

@export var player: Node2D

var playerEntered=false

var talked=false

func talk():
	GameManager.canPause=false
	player.canMove=false
	dialogue.nameText="Critter Store Lady"
	dialogue.bodyText="Here to buy some overpriced goods? Too bad. I don't have anything in stock."
	speechPage=1
	dialogue.speaker=self
	dialogue.loadDialogue()
		
		
func nextText():
	dialogue.visible=false
	player.canMove=true
	playerEntered=false
	return
	


func _process(_delta: float) -> void:
	if(playerEntered and Input.is_action_just_pressed("Interact") and not talked):
		talked=true
		talk()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	playerEntered=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	playerEntered=false
