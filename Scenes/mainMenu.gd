extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FileAccess.file_exists("user://save-1.tres"):
		$Menu/Load.visible=true
		$Menu/New.size=$Menu/Load.size
		$Menu/New.position.x=$Menu/Load.position.x
		$Menu/New.text="New Game"
		var data = load("user://save-1.tres") as GameData
		$Menu/Control/VBoxContainer/SaveSlot/TeamSlot.loadPokemon(data.team.team[0])
	else:
		$Menu/Load.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(get_global_mouse_position())
	$Camera2D.global_position=get_global_mouse_position()/20
	$Camera2D.global_position+=Vector2(480, 270)


func _on_new_pressed() -> void:
	pass # Replace with function body.


func _on_load_pressed() -> void:
	pass # Replace with function body.
