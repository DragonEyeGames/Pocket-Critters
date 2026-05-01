extends Sprite2D

var speed
var time = 0.0

func _ready():
	var size = randf_range(0.7, 1.5)
	size*=2.5
	scale = Vector2.ONE * size
	
	speed = -lerp(10.0, 2.0, (size - 0.7) / 0.8)
	time = randf_range(0, 100)

func _process(delta):
	time += delta
	
	position.x -= speed * delta
	position.y += sin(time * 0.5) * 0.1
	
	if(position.x<-140): 
		position.x=1083
