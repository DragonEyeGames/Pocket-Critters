extends Control

var pokemon
var mouseEntered=false
var canRecieve=true

func initialize():
	if(pokemon==null):
		visible=false
		#queue_free()
		return
	$NewPokemon.pokemon=pokemon.species
	$NewPokemon.initialize()
	$NewPokemon.position=Vector2(58, 52)
	#$NamePlate/Name.text=GameManager.pokemonName(pokemon.species)
	$NamePlate/Name.text=pokemon.name
	fitText()


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
		get_parent().get_parent().get_parent().get_parent().removeInput()
	if(get_parent().get_parent().name=="Team"):
		$OptionsMenu/VBoxContainer/Switch/MouseChecker.visible=len(GameManager.playerTeam)>1
	else:
		$OptionsMenu/VBoxContainer/Switch/MouseChecker.visible=len(GameManager.playerTeam)<6
		
func buttonPressed(action: String):
	if(action=="Switch"):
		if(get_parent().get_parent().name=="Team"):
			GameManager.playerTeam.erase(pokemon)
			GameManager.playerBoxes.append(pokemon)
			$OptionsMenu.visible=false
			get_parent().get_parent().get_parent().get_parent().restoreInput()
			$"../../../..".initializeSlots()
		else:
			GameManager.playerBoxes.erase(pokemon)
			GameManager.playerTeam.append(pokemon)
			$OptionsMenu.visible=false
			get_parent().get_parent().get_parent().get_parent().restoreInput()
			$"../../../..".initializeSlots()
	if(action=="Stats"):
		Stats.displayStats(pokemon)
	if(action=="Critterdex"):
		print(GameManager.pokemonName(pokemon.species))
		Info.display(pokemon)
	if(action=="Close"):
		$OptionsMenu.visible=false
		get_parent().get_parent().get_parent().get_parent().restoreInput()
	
func fitText():
	var font = $NamePlate/Name.get_theme_font("font")
	var sizes = 16  # your pixel font size

	var text_width = font.get_string_size($NamePlate/Name.text, HORIZONTAL_ALIGNMENT_LEFT, -1, sizes).x
	var text_height = font.get_height(sizes)
	var widthPercent = 110/text_width
	var heightPercent = 20/text_height
	var largestVal = min(widthPercent, heightPercent)
	largestVal/=.9
	$NamePlate/Name.scale=Vector2(largestVal, largestVal)
	#$Name.scale = Vector2(text_width + 20, text_height + 10)
