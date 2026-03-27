extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(not GameManager.evolutionSpecies in GameManager.seenDex):
		GameManager.seenDex.append(GameManager.evolutionSpecies)
	if(not GameManager.evolutionSpecies in GameManager.pokedex):
		GameManager.pokedex.append(GameManager.evolutionSpecies)
	$CurrentPokemon.pokemon=GameManager.evolvedSpecies
	$NewPokemon.pokemon=GameManager.evolutionSpecies
	$CurrentPokemon.initialize()
	$NewPokemon.initialize()
	$Evolve.play("evolve")
	
func _process(_delta: float) -> void:
	$CurrentPokemon.visible=!$NewPokemon.visible


func _on_evolve_animation_finished(_anim_name: StringName) -> void:
	await get_tree().create_timer(2).timeout
	GameManager.toMain()
