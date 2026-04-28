extends CanvasLayer

@export var pokemon: PokemonData
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false
	rename(GameManager.playerTeam[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Choose.disabled=$LineEdit.text.length()==0
	if(visible):
		get_tree().paused=true

func rename(newPokemon: PokemonData):
	pokemon=newPokemon
	initialize()
	
func initialize():
	$PokemonHolder/NewPokemon.pokemon=pokemon.species
	$PokemonHolder/NewPokemon.initialize()
	$Name.text=pokemon.name
	


func _on_choose_pressed() -> void:
	pokemon.name=$LineEdit.text
	get_tree().paused=false
	visible=false


func _on_skip_pressed() -> void:
	get_tree().paused=false
	visible=false
