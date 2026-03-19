extends Node2D

@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for thing in get_tree().get_nodes_in_group("Y-Sort"):
		var global = thing.global_position
		
		thing.get_parent().call_deferred("remove_child", thing)
		call_deferred("add_child", thing)
		
		thing.global_position = global
