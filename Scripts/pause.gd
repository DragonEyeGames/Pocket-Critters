extends CanvasLayer

var paused=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Pause")):
		paused = !paused
		get_tree().paused=paused
		$Menu.visible=paused
		$"Team Menu".visible=false


func _on_team_pressed() -> void:
	$"Team Menu".visible=true
	for child in $"Team Menu/GridContainer".get_children():
		child.loadSlot()
