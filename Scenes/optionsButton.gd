extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween=create_tween()
	tween.tween_property(self, "modulate", Color.LIGHT_GRAY, .1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_mouse_checker_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, .1)


func _on_mouse_checker_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property(self, "modulate", Color.LIGHT_GRAY, .1)
