extends CanvasLayer

var paused=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Menu.visible=false
	$"Team Menu".visible=false
	$"Reorder Team".visible=false
	$Pokedex.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(not GameManager.canPause):
		return
	if(Input.is_action_just_pressed("Pause")):
		if($Menu.visible and ($"Team Menu".visible or $"Reorder Team".visible or $Pokedex.visible or $"Confirm Delete".visible)):
			$"Team Menu".visible=false
			$"Reorder Team".visible=false
			$Pokedex.visible=false
			$"Confirm Delete".visible=false
		else:
			paused = !paused
			get_tree().paused=paused
			$Menu.visible=paused
		


func _on_team_pressed() -> void:
	$"Team Menu".visible=true
	for child in $"Team Menu/GridContainer".get_children():
		child.loadSlot()


func _on_reorder_pressed() -> void:
	$"Reorder Team".visible=true
	for child in $"Reorder Team/GridContainer".get_children():
		child.initialize()


func _on_button_pressed() -> void:
	$"Reorder Team".visible=false


func _on_pokedex_pressed() -> void:
	GameManager.pokedex.sort()
	$Pokedex.visible=true
	for child in $Pokedex/GridContainer.get_children():
		child.initialize()


func _on_save_pressed() -> void:
	$Menu/VBoxContainer/Save/save.disabled=true
	$Menu/VBoxContainer/Save/save.text="Saving"
	$Save.play()
	await GameManager.saveGame()
	await get_tree().create_timer(.4).timeout
	$Menu/VBoxContainer/Save/save.text="Saved"
	await get_tree().create_timer(1).timeout
	$Menu/VBoxContainer/Save/save.text="Save"
	$Menu/VBoxContainer/Save/save.disabled=false


func _on_close_pressed() -> void:
	if($Menu.visible and ($"Team Menu".visible or $"Reorder Team".visible or $Pokedex.visible)):
		$"Team Menu".visible=false
		$"Reorder Team".visible=false
		$Pokedex.visible=false
	else:
		paused = !paused
		get_tree().paused=paused
		$Menu.visible=paused


func _on_wipe_pressed() -> void:
	$"Confirm Delete".visible=true


func _on_confirm_delete_pressed() -> void:
	get_tree().paused=false
	GameManager.wipeSave()


func _on_deny_delete_pressed() -> void:
	$"Confirm Delete".visible=false
