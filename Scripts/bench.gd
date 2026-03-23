extends Node2D

var playerEntered=false
var player
var inProgress=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(playerEntered and Input.is_action_just_pressed("Interact") and not inProgress):
		player.canMove=false
		GameManager.canPause=false
		inProgress=true
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		player.sprite.play("up-walk")
		player.direction="up"
		player.state="walk"
		player.overrideWalking=true
		GameManager.respawnSpot=Vector2(global_position.x, global_position.y+1)
		var tween=create_tween()
		tween.tween_property(player, "global_position", Vector2(global_position.x, global_position.y+1), .5)
		await tween.finished
		player.sprite.play("down-idle")
		player.direction="down"
		player.overrideWalking=false
		await get_tree().create_timer(.5).timeout
		var tween2=create_tween()
		tween2.tween_property($Dark/ColorRect, "color:a", 1, .4)
		$Heal.play()
		await tween2.finished
		for pokemon in GameManager.playerTeam:
			pokemon.health=pokemon.maxHealth
		GameManager.playerPosition=Vector2(global_position.x, global_position.y+1)
		await GameManager.saveGame()
		await get_tree().create_timer(2).timeout
		var tween3=create_tween()
		tween3.tween_property($Dark/ColorRect, "color:a", 0, .4)
		await tween3.finished
		player.canMove=true
		playerEntered=false
		inProgress=false
		GameManager.canPause=true
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)


func _on_area_2d_area_entered(area: Area2D) -> void:
	playerEntered=true
	player=area.get_parent()


func _on_area_2d_area_exited(_area: Area2D) -> void:
	playerEntered=false
