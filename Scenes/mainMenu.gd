extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FileAccess.file_exists("user://save-1.tres") or FileAccess.file_exists("user://save-2.tres") or FileAccess.file_exists("user://save-3.tres"):
		$Menu/Load.visible=true
		$Menu/New.size=$Menu/Load.size
		$Menu/New.position.x=$Menu/Load.position.x
		$Menu/New.text="New Game"
	else:
		$Menu/Load.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#print(get_global_mouse_position())
	$Camera2D.global_position=get_global_mouse_position()/20
	$Camera2D.global_position+=Vector2(480, 270)


func _on_new_pressed() -> void:
	var toMake=-1
	if(not FileAccess.file_exists("user://save-1.tres")):
		toMake = 1
	elif(not FileAccess.file_exists("user://save-2.tres")):
		toMake = 2
	elif(not FileAccess.file_exists("user://save-3.tres")):
		toMake=3
	if(not toMake==-1):
		Music.closeMenu()
		GameManager.loadedSave=toMake
		GameManager.initialize()
		return
	else:
		$Menu/NewSave.open()


func _on_load_pressed() -> void:
	$Menu/LoadSave.open()
