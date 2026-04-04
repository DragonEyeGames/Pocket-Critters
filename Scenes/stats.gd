extends CanvasLayer

@export var center: Vector2 = Vector2(0, 0)
@export var radius: float = 100.0
@export var stats: Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
var perfectStats: Array = [1.1, 1.1, 1.1, 1.1, 1.1, 1.1]

func _ready() -> void:
	visible=false
	displayStats(GameManager.playerTeam[0])

func displayStats(pokemon: PokemonData):
	visible=true
	$Name.text=str(GameManager.pokemonName(pokemon.species))
	$PokemonHolder/NewPokemon.pokemon=pokemon.species
	$PokemonHolder/NewPokemon.initialize()
	var size = $PokemonHolder/NewPokemon/Pokemon.texture.get_size()
	var newScale = 50.0 / max(size.x, size.y)
	$PokemonHolder/NewPokemon/Pokemon.scale = Vector2(newScale, newScale)
	stats.clear()
	stats.append(pokemon.ivHealth)
	$IVHolder/Health.text=str("HP:  " + str(normalize(round(pokemon.ivHealth*100)/100)))
	stats.append(pokemon.ivAttack)
	$IVHolder/Attack.text=str("Atk:  " + str(normalize(round(pokemon.ivAttack*100)/100)))
	stats.append(pokemon.ivDefense)
	$IVHolder/Defense.text=str("Def:  " + str(normalize(round(pokemon.ivDefense*100)/100)))
	stats.append(pokemon.ivSpecialAttack)
	$IVHolder/SpecialAttack.text=str("Sp. Atk:  " + str(normalize(round(pokemon.ivSpecialAttack*100)/100)))
	stats.append(pokemon.ivSpecialDefense)
	$IVHolder/SpecialDefense.text=str("Def:  " + str(normalize(round(pokemon.ivSpecialDefense*100)/100)))
	stats.append(pokemon.ivSpeed)
	$IVHolder/Speed.text=str("Spd:  " + str(normalize(round(pokemon.ivSpeed*100)/100)))
	_draw(stats, $IVHolder/IVSpread)
	_draw(perfectStats, $IVHolder/NominalSpread)
	
func normalize(iv: float) -> float:
	return (iv - 0.9) / (1.1 - 0.9)
	
func get_points(array) -> Array:
	var points = []
	var count = stats.size()
	
	for i in count:
		var angle = TAU * i / count - PI / 2
		
		var value = normalize(array[i])
		var r = radius * value
		
		var x = center.x + cos(angle) * r
		var y = center.y + sin(angle) * r
		
		points.append(Vector2(x, y))
	
	return points
	
func _draw(array, polygon):
	var points = get_points(array)
	polygon.polygon = points
