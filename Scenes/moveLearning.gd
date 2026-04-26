extends Control

var pokemon: PokemonData
var newMove: MoveDatas
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pokemon=GameManager.learningPokemon
	newMove=GameManager.learningMove
	$NewPokemon.pokemon=pokemon.species
	$NewPokemon.initialize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
