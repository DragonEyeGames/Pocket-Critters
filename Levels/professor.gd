extends Node2D

var ID: int = 0

var sprite
@export var dialogue: CanvasLayer

@export var trainerData: TrainerData

var speechPage=0

@export var player: Node2D

@export var radius:=70

var walkingAway=false

var battleTeam: Array[PokemonData] = []
var defeated=false

var playerEntered=false
var afterSpeaking=false

@export var combatant:=true

var playerNamed=false
var geckrowNamed=false

func _ready():
	$Area2D/CollisionShape2D.shape.radius=radius
	if(trainerData==null):
		call_deferred("queue_free")
		return
	ID=0
	if ID == 0:
		ID = str(get_path()).hash()
	if(ID in GameManager.defeated):
		call_deferred("queue_free")
	for child in $Sprites.get_children():
		child.visible=false
	sprite=get_node("Sprites/" + trainerData.sprite)
	sprite.visible=true
	if(trainerData.rival==1 and GameManager.blaze1):
		visible=false
		call_deferred("queue_free")
	SignalBus.defeated.connect(_on_defeat)
	if(combatant):
		for member in trainerData.team:
			battleTeam.append(GameManager.setPokemon(member.species, member.level, member.moves))
	await get_tree().create_timer(1).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(defeated):
		return
	GameManager.camera.target=self
	GameManager.canPause=false
	area.get_parent().canMove=false
	dialogue.nameText=trainerData.trainerName
	dialogue.bodyText=trainerData.preFightDialogue[0]
	speechPage=1
	dialogue.speaker=self
	dialogue.loadDialogue()

func nextText():
	if(playerEntered):
		dialogue.visible=false
		player.canMove=true
		playerEntered=false
		GameManager.camera.target=player
		afterSpeaking=false
		return
	if(len(trainerData.preFightDialogue)>speechPage and not defeated):
		dialogue.nameText=trainerData.trainerName
		dialogue.bodyText=trainerData.preFightDialogue[speechPage]
		dialogue.loadDialogue()
		speechPage+=1
	else:
		if(not playerNamed):
			NamePlayer.initialize()
			print("AFter the funtera")
			get_tree().paused=true
			while get_tree().paused:
				await get_tree().process_frame
			playerNamed=true
			dialogue.nameText=trainerData.trainerName
			dialogue.bodyText="And now name your first partner. It is thought to be impossible to forget your first critter."
			dialogue.loadDialogue()
		elif(not geckrowNamed):
			Rename.rename(GameManager.playerTeam[0])
			while get_tree().paused:
				await get_tree().process_frame
			defeated=true
			GameManager.defeated.append(ID)
			geckrowNamed=true
			speechPage=0
			nextText()
		elif(len(trainerData.afterFightDialogue)>speechPage):
			dialogue.nameText=trainerData.trainerName
			dialogue.bodyText=trainerData.afterFightDialogue[speechPage]
			dialogue.loadDialogue()
			speechPage+=1
		else:
			dialogue.visible=false
			player.canMove=true
			GameManager.camera.target=player
			GameManager.canPause=true
			#$Area2D.queue_free()
			sprite.play("walk-up")
			walkingAway=true
		
func _on_defeat(trainerID):
	if(trainerID==ID):
		player.canMove=false
		
		dialogue.nameText=trainerData.trainerName
		dialogue.bodyText=trainerData.afterFightDialogue[0]
		speechPage=1
		dialogue.speaker=self
		defeated=true
		dialogue.loadDialogue()
		if(trainerData.rival==1):
			await get_tree().create_timer(2).timeout
			GameManager.blaze1=true
		
func _process(_delta: float) -> void:
	if(walkingAway):
		position.y-=2
	if(playerEntered and Input.is_action_just_pressed("Interact") and not afterSpeaking):
		afterSpeaking=true
		GameManager.camera.target=self
		GameManager.canPause=false
		player.canMove=false
		dialogue.nameText=trainerData.trainerName
		dialogue.bodyText=trainerData.afterDefeatDialogue[0]
		speechPage=1
		dialogue.speaker=self
		dialogue.loadDialogue()


func _on_player_small_area_entered(_area: Area2D) -> void:
	playerEntered=true


func _on_player_small_area_exited(_area: Area2D) -> void:
	playerEntered=false
