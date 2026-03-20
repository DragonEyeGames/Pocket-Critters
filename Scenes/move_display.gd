extends Control

var move
var moveName
var moveType
var movePower
var moveAccuracy
var attackType
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func loadMove(newMove):
	move=newMove
	visible=true
	moveName=str(move.name)
	moveType=move.type
	movePower=move.power
	moveAccuracy=move.accuracy
	attackType=move.moveType
	$ColorRect/Name.text=str(move.name)
	$ColorRect/Power.text=str(move.power)
	$ColorRect/Accuracy.text=str(int(move.accuracy*100)) + "%"
	$ColorRect/Type.text=str(GameManager.moveTypes.keys()[move.moveType])
	for child in $Types.get_children():
		child.visible=false
	$"Type Animator".play(str(GameManager.types.keys()[move.type]))
