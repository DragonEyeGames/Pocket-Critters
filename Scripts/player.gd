extends CharacterBody2D


@export var speed = 30
@onready var sprite = $Sprite
var canMove=true
@export var positionOverride=false

var overrideWalking:=false

var direction = "down"
var state="idle"

func _ready() -> void:
	GameManager.player=self
	SignalBus.loadData.connect(_load)
	if(not positionOverride):
		global_position=GameManager.playerPosition

func _process(_delta: float) -> void:
	if(canMove):
		velocity = Input.get_vector("left", "right", "up", "down") * speed
	else:
		velocity=Vector2.ZERO
	move_and_slide()
	if(velocity.x<-.5):
		direction="left"
	elif(velocity.x>.5):
		direction = "right"
	elif(velocity.y<-.5):
		direction = "up"
	elif(velocity.y>.5):
		direction = "down"
	
	var motion = get_last_motion()

	if motion.length() > 0.1:
		state = "walk"
	else:
		state = "idle"
		
	if(overrideWalking):
		state="walk"
		
	sprite.play(direction + "-" + state)
	
func _load():
	position=GameManager.playerPosition


func _on_mud_area_entered(_area: Area2D) -> void:
	speed/=3


func _on_mud_area_exited(_area: Area2D) -> void:
	speed*=3
