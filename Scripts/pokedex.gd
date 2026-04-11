extends Control

var backupI = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pokemonValues = GameManager.pokemon.values()
	var i = 0
	for child in $GridContainer.get_children():
		child.pokemon=pokemonValues[i]
		i+=1


func _on_right_pressed() -> void:
	var pokemonValues = GameManager.pokemon.values()
	backupI+=15
	var i = backupI
	if(i>len(pokemonValues)-1):
		backupI-=15
		return
	for child in $GridContainer.get_children():
		if(i>len(pokemonValues)-1):
			child.visible=false
		else:
			child.visible=true
			child.pokemon=pokemonValues[i]
			child.initialize()
		i+=1


func _on_left_pressed() -> void:
	var pokemonValues = GameManager.pokemon.values()
	backupI-=15
	if(backupI<0):
		backupI=0
		return
	var i = backupI
	for child in $GridContainer.get_children():
		child.visible=true
		child.pokemon=pokemonValues[i]
		child.initialize()
		i+=1
