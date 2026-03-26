extends Node2D

var ID: int = 0

var sprite
@export var dialogue: CanvasLayer

var speechPage=0

@export var player: Node2D

var playerEntered=false
var healing=false
var healed=false
var alreadyHealed=false

func talk():
	GameManager.canPause=false
	player.canMove=false
	alreadyHealed=true
	for pokemon in GameManager.playerTeam:
		if(pokemon.health!=pokemon.maxHealth):
			alreadyHealed=false
	dialogue.nameText="Critter Center Man"
	if(!alreadyHealed):
		dialogue.bodyText="Give me your critters. They look sickly."
	else:
		dialogue.bodyText="Your critters are fine. I atleast can't fix whats wrong with them."
	speechPage=1
	dialogue.speaker=self
	dialogue.loadDialogue()
		
		
func nextText():
	if(not healed):
		healed=true
	if(healed or alreadyHealed):
		healed=false
		healing=false
		dialogue.visible=false
		player.canMove=true
		playerEntered=false
		return
	dialogue.visible=false
	var i=0
	for pokemon in GameManager.playerTeam:
		pokemon.health=pokemon.maxHealth
		$"../../CritterBallHolder".get_child(i).visible=true
		await get_tree().create_timer(.2).timeout
		i+=1
	$Heal.play()
	$"../../CritterBallHolder/Heal".play("heal")
	await get_tree().create_timer(2).timeout
	for child in $"../../CritterBallHolder".get_children():
		if(child is Node2D):
			child.visible=false
	dialogue.visible=true
	dialogue.bodyText="They are perfectly healthy. Except for appearance. Now go away."
	dialogue.loadDialogue()
	


func _process(_delta: float) -> void:
	if(playerEntered and Input.is_action_just_pressed("Interact") and not healing):
		healing=true
		talk()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	playerEntered=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	playerEntered=false
