extends Sprite2D

var playerEntered:=false
var entered=false
var backupZoomPoint
var locked=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Screen.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(playerEntered and Input.is_action_just_pressed("Interact") and not entered):
		backupZoomPoint=GameManager.camera.target
		GameManager.camera.target=$ZoomPoint
		GameManager.camera.zoomChange(Vector2(55, 55))
		GameManager.player.canMove=false
		$Screen.visible=true
		entered=true
		await get_tree().create_timer(.2).timeout
		$Screen/animator.play("initialize")
	elif(playerEntered and Input.is_action_just_pressed("Interact") and entered and not locked):
		GameManager.camera.target=backupZoomPoint
		GameManager.camera.zoomChange(Vector2(2.3, 2.3))
		GameManager.player.canMove=true
		$Screen.visible=false
		entered=false


func _on_area_2d_area_entered(_area: Area2D) -> void:
	playerEntered=true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	playerEntered=false
