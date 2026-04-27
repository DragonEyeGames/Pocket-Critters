extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func bootUp():
	#GameManager.playerBoxes.append(GameManager.newPokemon(GameManager.pokemon.Sligment, 8))
	#GameManager.playerBoxes.append(GameManager.newPokemon(GameManager.pokemon.Bonfur, 8))
	#GameManager.playerBoxes.append(GameManager.newPokemon(GameManager.pokemon.Goanopy, 8))
	#GameManager.playerBoxes.append(GameManager.newPokemon(GameManager.pokemon.Merlicun, 8))
	#GameManager.playerBoxes.append(GameManager.newPokemon(GameManager.pokemon.Criminalis, 8))
	$animator.play("initialize")
	var i = 0
	for child in $Normal/GridContainer.get_children():
		child.visible=false
	for pokemon in GameManager.playerBoxes:
		$Normal/GridContainer.get_child(i).pokemon=pokemon
		$Normal/GridContainer.get_child(i).initialize()
		$Normal/GridContainer.get_child(i).visible=true
		i+=1
		
func removeInput():
	for child in $Normal/GridContainer.get_children():
		child.canRecieve=false

func restoreInput():
	for child in $Normal/GridContainer.get_children():
		child.canRecieve=true
