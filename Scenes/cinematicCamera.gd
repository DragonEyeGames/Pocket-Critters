extends Camera2D

var startingPosition = Vector2(480, 270)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position=Vector2(480, 270)


func shake(movePower):
	var divisor = 7.5
	for i in range(0, 15):
		position.x=startingPosition.x + randf_range(-movePower/divisor, movePower/divisor)
		position.y=startingPosition.y + randf_range(-movePower/divisor, movePower/divisor)
		await get_tree().process_frame
	position=startingPosition
