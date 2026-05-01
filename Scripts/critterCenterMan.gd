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
	dialogue.nameText="Doctor Fizz"
	if(!alreadyHealed):
		dialogue.bodyText="Hello there young lad. Your critters need some healing?"
	else:
		dialogue.bodyText="Did you come all this way just to see me? Your critters are in good shape!"
	speechPage=1
	dialogue.speaker=self
	dialogue.loadDialogue()
		
		
func nextText():
	if(healed or alreadyHealed):
		healed=false
		healing=false
		dialogue.visible=false
		player.canMove=true
		playerEntered=false
		return
	if(not healed):
		healed=true
	dialogue.visible=false
	#var i=0
	for pokemon in GameManager.playerTeam:
		pokemon.health=pokemon.maxHealth
		#$"../../CritterBallHolder".get_child(i).visible=true
		#await get_tree().create_timer(.2).timeout
		#i+=1
	$Animator.play("heal")
	await get_tree().create_timer(.6).timeout
	$Heal.play()
	#$"../../CritterBallHolder/Heal".play("heal")
	
	await get_tree().create_timer(1.4).timeout
#	for child in $"../../CritterBallHolder".get_children():
#		if(child is Node2D):
#			child.visible=false
	dialogue.visible=true
	dialogue.bodyText="Now your critters are just as good as they ever were. Have fun!"
	dialogue.loadDialogue()
	


func _process(_delta: float) -> void:
	if(playerEntered and Input.is_action_just_pressed("Interact") and not healing):
		healing=true
		talk()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	playerEntered=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	playerEntered=false
