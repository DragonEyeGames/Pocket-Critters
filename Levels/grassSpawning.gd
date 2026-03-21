extends TileMapLayer

@export var grass: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cell in get_used_cells():
		var instance = grass.instantiate()
		
		var pos =map_to_local(cell)
		pos += Vector2(60, 116) / 2
		pos = to_global(pos)
		instance.global_position = pos
		add_child(instance)
