extends Node2D

@export var back:=false
@export var pokemon: GameManager.pokemon

# Called when the node enters the scene tree for the first time.
func initialize() -> void:
	if(back):
		for child in $Back.get_children():
			if(child.name==str(GameManager.pokemon.keys()[pokemon])):
				child.visible=true
	elif(!back):
		for child in $Front.get_children():
			if(child.name==str(GameManager.pokemon.keys()[pokemon])):
				child.visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
