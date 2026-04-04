extends CanvasLayer

@export var center: Vector2 = Vector2(0, 0)
@export var radius: float = 100.0
@export var stats: Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0]
@export var perfectStats: Array = [1.1, 1.1, 1.1, 1.1, 1.1, 1.1]

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
	_draw(stats, $IVHolder/IVSpread)
	_draw(perfectStats, $IVHolder/NominalSpread)
	
func normalize(iv: float) -> float:
	return (iv - 0.9) / (1.1 - 0.9)
	
func get_points(array) -> Array:
	var points = array
	var count = stats.size()
	
	for i in count:
		var angle = TAU * i / count - PI / 2
		
		var value = normalize(stats[i])
		var r = radius * value
		
		var x = center.x + cos(angle) * r
		var y = center.y + sin(angle) * r
		
		points.append(Vector2(x, y))
	
	return points
	
func _draw(array, polygon):
	var points = get_points(array)
	polygon.polygon = points
