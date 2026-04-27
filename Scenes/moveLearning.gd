extends Control

var pokemon: PokemonData
var newMove: MoveDatas
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pokemon=GameManager.learningPokemon
	newMove=GameManager.learningMove.move
	pokemon.uncheckedMoves.erase(GameManager.learningMove)
	$NewPokemon.pokemon=pokemon.species
	$NewPokemon.initialize()
	$Learning.loadMove(newMove)
	if(len(pokemon.moves)==4):
		$Move1.loadMove(pokemon.moves[0])
		$Move2.loadMove(pokemon.moves[1])
		$Move3.loadMove(pokemon.moves[2])
		$Move4.loadMove(pokemon.moves[3])
	else:
		pokemon.moves.append(newMove)
		GameManager.toMain()
	$Visuals/Text.text=pokemon.name + " would like to learn the move " + newMove.name + ".\nReplace an old move to learn or skip learning."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_skip_pressed() -> void:
	GameManager.toMain()


func replace1() -> void:
	pokemon.moves[0]=newMove
	GameManager.toMain()


func replace2() -> void:
	pokemon.moves[1]=newMove
	GameManager.toMain()


func replace3() -> void:
	pokemon.moves[2]=newMove
	GameManager.toMain()


func replaced4() -> void:
	pokemon.moves[3]=newMove
	GameManager.toMain()
