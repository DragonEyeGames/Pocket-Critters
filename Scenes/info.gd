extends CanvasLayer

@export var species: SpeciesData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize()

func initialize():
	if(species==null):
		return
	print(species.species)
	$PokemonHolder/NewPokemon.pokemon=species.species
	$PokemonHolder/NewPokemon.initialize()
	$Name.text=GameManager.pokemonName(species.species)
	$Name.text+=" #" + str(species.species+1).pad_zeros(2)
	if(species.species < PokedexText.pokemonTitle.size()):
		$Title/title.text=PokedexText.pokemonTitle[species.species]
	else:
		$Title/title.text="Unwritten Critter"
	if(species.species < PokedexText.pokemonDescription.size()):
		$Description/description.text=PokedexText.pokemonDescription[species.species]
	else:
		$Description/description.text="Unwritten. Mr. Taxalottle has to get on that."
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
		#$Types/Type.visible=false
		#$Types/Type2.visible=false
	
func close():
	visible=false


func nextPage() -> void:
	if(species==null):
		return
	var speciesInt=species.species+1
	if(speciesInt>=GameManager.pokemon.size()):
		return
	print(GameManager.pokemonName(speciesInt))
	if(ResourceLoader.exists("res://Pokemon/" + str(GameManager.pokemonName(speciesInt)).to_lower() + ".tres")):
		species=load("res://Pokemon/" + str(GameManager.pokemonName(speciesInt)).to_lower() + ".tres")
	else:
		species.species=species.species+1 as GameManager.pokemon
	initialize()


func lastPage() -> void:
	var speciesInt=species.species-1
	if(speciesInt<0):
		return
	print(GameManager.pokemonName(speciesInt))
	if(ResourceLoader.exists("res://Pokemon/" + str(GameManager.pokemonName(speciesInt)).to_lower() + ".tres")):
		species=load("res://Pokemon/" + str(GameManager.pokemonName(speciesInt)).to_lower() + ".tres")
	else:
		species.species=species.species-1 as GameManager.pokemon
	initialize()
