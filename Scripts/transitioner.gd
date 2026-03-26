extends CanvasLayer

var finished=false

func _ready() -> void:
	visible=true

func darkenScreen():
	finished=false
	$AnimationPlayer.play("darken")
	while not finished:
		await get_tree().process_frame
	return

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	finished=true
