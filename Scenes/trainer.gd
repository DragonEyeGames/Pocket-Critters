extends Node2D

@onready var sprite =$Sprite
@export var dialogue: CanvasLayer
@export var toSay : Array[String] = []
@export var speechPage=0

@export var team: Array[TeamData] = []

@export var player: Node2D

var walkingAway=false

var battleTeam: Array[PokemonData] = []
var defeated=false

func _ready():
	if(GameManager.blazeFled1):
		position.y=-1000
	SignalBus.defeated.connect(_on_defeat)
	for member in team:
		battleTeam.append(GameManager.setPokemon(member.species, member.level, member.moves))
		await get_tree().create_timer(1).timeout
		$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(defeated):
		return
	area.get_parent().canMove=false
	dialogue.nameText="???"
	dialogue.bodyText="Well well well. What do we have here? A wee-trainer trying to progress?"
	dialogue.speaker=self
	dialogue.loadDialogue()

func nextText():
	if(speechPage<2 and not defeated):
		dialogue.nameText="Blaze"
		dialogue.bodyText=toSay[speechPage]
		dialogue.loadDialogue()
		speechPage+=1
	else:
		if(not defeated):
			GameManager.playerPosition=player.global_position
			GameManager.trainerBattle("Blaze", battleTeam)
		elif(len(toSay)>speechPage):
			dialogue.nameText="Blaze"
			dialogue.bodyText=toSay[speechPage]
			dialogue.loadDialogue()
			speechPage+=1
		else:
			dialogue.visible=false
			player.canMove=true
			$Area2D.queue_free()
			sprite.play("walk-up")
			walkingAway=true
			GameManager.blazeFled1=true
		
func _on_defeat(trainerName):
	if(trainerName=="Blaze"):
		player.canMove=false
		
		dialogue.nameText="Blaze"
		dialogue.bodyText="I will not be defeated by the likes of you."
		speechPage=2
		dialogue.speaker=self
		defeated=true
		dialogue.loadDialogue()
		
func _process(_delta: float) -> void:
	if(walkingAway):
		position.y-=1
