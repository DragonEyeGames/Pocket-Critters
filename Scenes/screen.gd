extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func bootUp():
	GameManager.playerBoxes.append(GameManager.newPokemon(GameManager.pokemon.Sligment, 8))
	$animator.play("initialize")
	var i = 0
	for child in $Normal/GridContainer.get_children():
		child.visible=false
	print(GameManager.playerBoxes)
	for pokemon in GameManager.playerBoxes:
		print(str(pokemon.species) + " Is pokemon")
		$Normal/GridContainer.get_child(i).pokemon=pokemon.species
		$Normal/GridContainer.get_child(i).initialize()
		$Normal/GridContainer.get_child(i).visible=true
		i+=1
