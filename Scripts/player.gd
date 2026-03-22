extends CharacterBody2D


@export var speed = 30
@onready var sprite = $Sprite
var canMove=true

var overrideWalking:=false

var direction = "down"
var state="idle"

func _ready() -> void:
	SignalBus.loadData.connect(_load)
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
