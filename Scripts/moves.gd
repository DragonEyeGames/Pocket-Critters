extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func loadMoves(moves):
	visible=true
	for child in get_children():
		child.visible=false
	var i = 0
	for move in moves:
		get_child(i).loadMove(move)
		i+=1
