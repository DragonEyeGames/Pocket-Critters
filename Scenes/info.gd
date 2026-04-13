extends CanvasLayer

@export var species: SpeciesData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()

func initialize():
	print(species.species)
	$PokemonHolder/NewPokemon.pokemon=species.species
	$PokemonHolder/NewPokemon.initialize()
	$Name.text=GameManager.pokemonName(species.species)
	$Name.text+=" #" + str(species.species+1).pad_zeros(2)
	$Title/title.text=PokedexText.pokemonTitle[species.species]
	$Description/description.text=PokedexText.pokemonDescription[species.species]
	$Types/Type.type=species.type1
	$Types/Type.initialize()
	$Types/Type.visible=true
	$Types/Type2.visible=true
	
	if(species.type2!=species.type1):
		$Types/Type2.type=species.type2
		$Types/Type2.initialize()
	else:
		$Types/Type2.visible=false
	if(species.species not in GameManager.seenDex):
		$PokemonHolder/NewPokemon.modulate=Color.BLACK
		$Title/title.text="???"
		$Description/description.text="???"
		$Types/Type.visible=false
		$Types/Type2.visible=false
	
func close():
	visible=false
