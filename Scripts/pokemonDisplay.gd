extends Node2D

@export var pokemon: GameManager.pokemon

func initialize():
	if not ResourceLoader.exists("res://Fakemon-PNG/" + str(GameManager.pokemonName(pokemon)).to_lower() + ".png"):
		return
	else:
		var tex = load("res://Fakemon-PNG/" + str(GameManager.pokemonName(pokemon)).to_lower() + ".png")
		$Pokemon.texture = tex
		var size = $Pokemon.texture.get_size()
		var newScale = 70.0 / max(size.x, size.y)
		$Pokemon.scale = Vector2(newScale, newScale)
