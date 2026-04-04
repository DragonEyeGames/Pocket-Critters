extends Control

@export var pokemon: GameManager.pokemon

func initialize():
	$NewPokemon.pokemon=pokemon
	$NewPokemon.initialize()
	$NewPokemon.position=Vector2(58, 63)


func _on_animator_animation_finished(_anim_name: StringName) -> void:
	for child in $"..".get_children():
		child.initialize()
