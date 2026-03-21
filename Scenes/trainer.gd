extends Node2D

@onready var sprite =$Sprite
@export var dialogue: CanvasLayer
@export var toSay : Array[String] = []
@export var speechPage=0


func _on_area_2d_area_entered(area: Area2D) -> void:
	area.get_parent().canMove=false
	dialogue.nameText="???"
	dialogue.bodyText="Well well well. What do we have here? A wee-trainer trying to progress?"
	dialogue.speaker=self
	dialogue.loadDialogue()

func nextText():
	if(len(toSay)>=speechPage+1):
		dialogue.nameText="Blaze"
		dialogue.bodyText=toSay[speechPage]
		dialogue.loadDialogue()
		speechPage+=1
