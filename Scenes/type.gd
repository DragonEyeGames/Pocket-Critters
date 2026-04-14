extends Node2D

@export var type: GameManager.types

func initialize():
	for child in $Types.get_children():
		child.visible=false
	if($TypeAnimator.has_animation(GameManager.types.keys()[type])):
		$TypeAnimator.play(GameManager.types.keys()[type])
	else:
		$TypeAnimator.play("Nonexistent")
