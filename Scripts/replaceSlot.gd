extends Control

@export var index:= 0
@export var bigBoss: Node

func _ready() -> void:
	initialize()

func initialize():
	if(len(GameManager.playerTeam)-1>=index):
		visible=true
		$NewPokemon.pokemon=GameManager.playerTeam[index].species
		$NewPokemon.initialize()
	else:
		visible=false


func _on_select_pressed() -> void:
	bigBoss.replacePokemon(index)
