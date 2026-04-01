extends Camera2D

@export var target: Node2D
@export var zoomOverride: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(not zoomOverride):
		zoom.x=2.5
		zoom.y=2.5
	GameManager.camera=self
	position_smoothing_enabled=false
	await get_tree().create_timer(.2).timeout
	position_smoothing_enabled=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(not target==null):
		global_position=round(target.global_position)


func _on_player_detector_area_entered(_area: Area2D) -> void:
	limit_left=-1015


func _on_player_detector_area_exited(_area: Area2D) -> void:
	limit_left=-655
	
func zoomChange(newZoom):
	#await get_tree().create_timer(.2).timeout
	#var tween = create_tween()
	#tween.tween_property(self, "zoom", newZoom, .1)
	zoom=newZoom
