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
	initializeSlots()
		
func removeInput():
	for child in $Normal/Team/GridContainer.get_children():
		child.canRecieve=false
	for child in $Normal/Storage/GridContainer.get_children():
		child.canRecieve=false

func restoreInput():
	for child in $Normal/Team/GridContainer.get_children():
		child.canRecieve=true
	for child in $Normal/Storage/GridContainer.get_children():
		child.canRecieve=true


func _on_close_pressed() -> void:
	get_parent().close()
	
func initializeSlots():
	var i = 0
	for child in $Normal/Storage/GridContainer.get_children():
		child.visible=false
	print($Normal/Storage/GridContainer.get_children())
	for pokemon in GameManager.playerBoxes:
		$Normal/Storage/GridContainer.get_child(i).pokemon=pokemon
		$Normal/Storage/GridContainer.get_child(i).initialize()
		$Normal/Storage/GridContainer.get_child(i).visible=true
		i+=1
	for child in $Normal/Team/GridContainer.get_children():
		child.visible=false
	i=0
	for pokemon in GameManager.playerTeam:
		print($Normal/Team/GridContainer.get_child(i))
		$Normal/Team/GridContainer.get_child(i).pokemon=pokemon
		$Normal/Team/GridContainer.get_child(i).initialize()
		$Normal/Team/GridContainer.get_child(i).visible=true
		i+=1
