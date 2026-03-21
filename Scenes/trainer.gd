extends Node2D

@export var ID: int

@onready var sprite =$Sprite
@export var dialogue: CanvasLayer

@export var trainerData: TrainerData

var speechPage=0

@export var player: Node2D

var walkingAway=false

var battleTeam: Array[PokemonData] = []
var defeated=false

func _ready():
	SignalBus.defeated.connect(_on_defeat)
	for member in trainerData.team:
		battleTeam.append(GameManager.setPokemon(member.species, member.level, member.moves))
		await get_tree().create_timer(1).timeout
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(defeated):
		return
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
			GameManager.trainerBattle(trainerData.trainerName, battleTeam, ID)
		elif(len(trainerData.afterFightDialogue)>speechPage):
			dialogue.nameText=trainerData.trainerName
			dialogue.bodyText=trainerData.afterFightDialogue[speechPage]
			dialogue.loadDialogue()
			speechPage+=1
		else:
			dialogue.visible=false
			player.canMove=true
			$Area2D.queue_free()
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
		
func _process(_delta: float) -> void:
	if(walkingAway):
		position.y-=1
