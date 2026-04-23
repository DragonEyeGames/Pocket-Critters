extends Control

var pokemon
var mouseEntered=false
var canRecieve=true

func initialize():
	if(pokemon==null):
		queue_free()
		return
	$NewPokemon.pokemon=pokemon.species
	$NewPokemon.initialize()
	$NewPokemon.position=Vector2(58, 52)
	$NamePlate/Name.text=GameManager.pokemonName(pokemon.species)


func _on_animator_animation_finished(_anim_name: StringName) -> void:
	for child in $"..".get_children():
		child.initialize()


func _on_mouse_detection_mouse_entered() -> void:
	mouseEntered=true
	var tween=create_tween()
	tween.tween_property($NewPokemon, "scale", Vector2(1.1, 1.1), .1)


func _on_mouse_detection_mouse_exited() -> void:
	mouseEntered=false
	var tween=create_tween()
	tween.tween_property($NewPokemon, "scale", Vector2(1, 1), .1)

func _process(_delta: float) -> void:
	$MouseDetection.visible=canRecieve
	if(Input.is_action_just_pressed("Interact") and mouseEntered):
		$OptionsMenu.visible=!$OptionsMenu.visible
		get_parent().get_parent().get_parent().removeInput()
		
func buttonPressed(action: String):
	if(action=="Switch"):
		pass
	if(action=="Stats"):
		Stats.displayStats(pokemon)
	if(action=="Critterdex"):
		print(GameManager.pokemonName(pokemon.species))
		Info.display(pokemon)
	if(action=="Close"):
		$OptionsMenu.visible=false
		get_parent().get_parent().get_parent().restoreInput()
	
