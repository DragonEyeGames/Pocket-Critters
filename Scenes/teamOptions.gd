extends Control

var mouseEntered=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween=create_tween()
	tween.tween_property(self, "modulate", Color.LIGHT_GRAY, .1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(mouseEntered and Input.is_action_just_pressed("Interact")):
		$"../../../..".buttonPress(get_parent().name)


func _on_mouse_checker_mouse_entered() -> void:
	mouseEntered=true
	var tween=create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, .1)


func _on_mouse_checker_mouse_exited() -> void:
	mouseEntered=false
	var tween=create_tween()
	tween.tween_property(self, "modulate", Color.LIGHT_GRAY, .1)
