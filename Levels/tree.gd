extends Node2D

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.seed = str(get_path()).hash()

	var variant = rng.randi() % get_child_count()
	var flip = rng.randf() <= 0.5
	
	for child in get_children():
		child.visible = false
	
	var tree = get_child(variant)
	tree.visible = true
	tree.flip_h = flip
