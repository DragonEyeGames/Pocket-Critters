extends Camera2D

@export var target: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.camera=self
	position_smoothing_enabled=false
	await get_tree().create_timer(.2).timeout
	position_smoothing_enabled=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position=target.global_position
