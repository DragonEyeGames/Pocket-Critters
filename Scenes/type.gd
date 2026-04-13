extends Node2D

@export var type: GameManager.types

func initialize():
	$TypeAnimator.play(GameManager.types.keys()[type])
