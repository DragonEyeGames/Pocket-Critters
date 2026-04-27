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
	$ColorRect/Power.text=str(move.power) + " Power"
	$ColorRect/Accuracy.text=str(int(move.accuracy*100)) + "% Accuracy"
	$ColorRect/Type.text=str(GameManager.moveTypes.keys()[move.moveType])
	var abilityDescription=""
	for ability in move.abilities:
		var individualDescription = ""
		print(GameManager.stats.keys()[ability.stat])
		individualDescription = str(int(ability.chance*100)) + "% chance to "
		if(ability.change==-1):
			individualDescription+="lower"
		elif(ability.change==-2):
			individualDescription+="greatly lower"
		elif(ability.change==1):
			individualDescription+="raise"
		elif(ability.change==2):
			individualDescription+="greatly raise"
		individualDescription+=" "
		if(ability.targetsSelf):
			individualDescription+="own "
		elif(!ability.targetsSelf):
			individualDescription+="opponent's "
		var moveTypes=str(GameManager.stats.keys()[ability.stat]).to_lower()
		if(ability.stat==GameManager.stats.SpecialAttack):
			moveTypes="special attack"
		if(ability.stat==GameManager.stats.SpecialDefense):
			moveTypes="special defense"
		individualDescription+=moveTypes
		if(ability.stat==GameManager.stats.Health):
			individualDescription="Increases health by 50% of damage dealt"
		if(ability.stat==GameManager.stats.Priority):
			individualDescription="Always goes first"
		abilityDescription+=individualDescription
		abilityDescription+=". "
	$ColorRect/Abilities.text=abilityDescription
	for child in $Types.get_children():
		child.visible=false
	$"Type Animator".play(str(GameManager.types.keys()[move.type]))
