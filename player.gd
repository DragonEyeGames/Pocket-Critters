extends CharacterBody2D


@export var speed = 30
@onready var sprite = $Sprite

var direction = "down"
var state="idle"

func _process(_delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down") * speed
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
		
	sprite.play(direction + "-" + state)
