extends Node2D

var ID: int = 0

var sprite
@export var dialogue: CanvasLayer

@export var trainerData: TrainerData

var speechPage=0

@export var player: Node2D

var walkingAway=false

var battleTeam: Array[PokemonData] = []
var defeated=false

func _ready():
	ID=0
	if ID == 0:
		ID = str(get_path()).hash()
	if(ID in GameManager.defeated):
		defeated=true
		speechPage=len(trainerData.afterFightDialogue)+1
	for child in $Sprites.get_children():
		child.visible=false
	sprite=get_node("Sprites/" + trainerData.sprite)
	sprite.visible=true
	if(trainerData.rival==1 and GameManager.blaze1):
		visible=false
		call_deferred("queue_free")
	SignalBus.defeated.connect(_on_defeat)
	for member in trainerData.team:
		battleTeam.append(GameManager.setPokemon(member.species, member.level, member.moves))
	await get_tree().create_timer(1).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(defeated):
		GameManager.camera.target=self
		GameManager.canPause=false
		area.get_parent().canMove=false
		dialogue.nameText=trainerData.trainerName
		dialogue.bodyText=trainerData.afterDefeatDialogue[0]
		speechPage=1
		dialogue.speaker=self
		dialogue.loadDialogue()
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
	if(len(trainerData.preFightDialogue)>speechPage and not defeated):
		dialogue.nameText=trainerData.trainerName
		dialogue.bodyText=trainerData.preFightDialogue[speechPage]
		dialogue.loadDialogue()
		speechPage+=1
	else:
		if(not defeated):
			GameManager.playerPosition=player.global_position
			Music.trainer()
			GameManager.canPause=true
			GameManager.trainerBattle(trainerData.trainerName, battleTeam, ID)
		elif(len(trainerData.afterFightDialogue)>speechPage):
			dialogue.nameText=trainerData.trainerName
			dialogue.bodyText=trainerData.afterFightDialogue[speechPage]
			dialogue.loadDialogue()
			speechPage+=1
		else:
			dialogue.visible=false
			player.canMove=true
			#$Area2D.queue_free()
			if(trainerData.rival!=0):
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
		position.y-=1
