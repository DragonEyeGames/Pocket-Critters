extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func loadMove(move):
	visible=true
	$ColorRect/Name.text=str(move.name)
	$ColorRect/Power.text=str(move.power)
	$ColorRect/Accuracy.text=str(int(move.accuracy*100)) + "%"
	$ColorRect/Type.text=str(GameManager.moveTypes.keys()[move.moveType])
