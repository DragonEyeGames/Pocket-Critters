extends Node2D

var ID: int = 0

@export var dialogue: CanvasLayer

var speechPage=0

@export var player: Node2D

@export var specialEncounter: TeamData

var pokemon: PokemonData

var playerEntered=false

var animating:=true

@export var preEncounter: Array[String]

func _ready():
	pokemon=(GameManager.setPokemon(specialEncounter.species, specialEncounter.level, specialEncounter.moves))
	await get_tree().create_timer(1).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _on_area_2d_area_entered(_area: Area2D) -> void:
	playerEntered=true
	
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") and playerEntered):
		var originalPos=$Sprite.position
		animating=true
		playerEntered=false
		GameManager.camera.target=self
		GameManager.canPause=false
		player.canMove=false
		dialogue.bodyText=preEncounter[0]
		speechPage=1
		dialogue.speaker=self
		dialogue.loadDialogue()
		for i in range(10):
			$Sprite.position.x+=randf_range(-1, 1)
			$Sprite.position.y+=randf_range(-1, 1)
			await get_tree().process_frame
			await get_tree().process_frame
			$Sprite.position=originalPos
		animating=false
		

func nextText():
	while(animating):
		await get_tree().process_frame
	if(len(preEncounter)>speechPage):
		dialogue.bodyText=preEncounter[speechPage]
		dialogue.loadDialogue()
		speechPage+=1
	else:
		GameManager.playerPosition=player.global_position
		Music.battle()
		GameManager.canPause=true
		GameManager.wildBattle(pokemon)


func _on_area_2d_area_exited(area: Area2D) -> void:
	playerEntered=false
	
