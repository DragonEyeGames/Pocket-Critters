extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CurrentPokemon.initialize()
	$NewPokemon.initialize()
	$Evolve.play("evolve")
	
func _process(delta: float) -> void:
	$CurrentPokemon.visible=!$NewPokemon.visible
