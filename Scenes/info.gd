extends CanvasLayer

@export var species: SpeciesData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(species.species)
	$PokemonHolder/NewPokemon.pokemon=species.species
	$PokemonHolder/NewPokemon.initialize()
	$Name.text=GameManager.pokemonName(species.species)
	
