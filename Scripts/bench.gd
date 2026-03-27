extends Node2D

var playerEntered=false
var player
var inProgress=false

enum directions {
	Front,
	Left,
	Right
}

@export var direction: directions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match direction:
		directions.Front:
			$Right.queue_free()
			$Left.queue_free()
			for child in $Front.get_children():
				var globalPos=child.global_position
				$Front.call_deferred("remove_child", child)
				call_deferred("add_child", child)
				child.set_deferred("global_position", globalPos)
		directions.Right:
			$Front.queue_free()
			$Left.queue_free()
			for child in $Right.get_children():
				var globalPos=child.global_position
				$Right.call_deferred("remove_child", child)
				call_deferred("add_child", child)
				child.set_deferred("global_position", globalPos)
		directions.Left:
			$Front.queue_free()
			$Right.queue_free()
			for child in $Left.get_children():
				var globalPos=child.global_position
				$Left.call_deferred("remove_child", child)
				call_deferred("add_child", child)
				child.set_deferred("global_position", globalPos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(playerEntered and Input.is_action_just_pressed("Interact") and not inProgress):
		player.canMove=false
		GameManager.canPause=false
		inProgress=true
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		match direction:
			directions.Front:
				player.sprite.play("up-walk")
				player.direction="up"
				player.state="walk"
			directions.Right:
				player.sprite.play("left-walk")
				player.direction="left"
				player.state="walk"
			directions.Left:
				player.sprite.play("right-walk")
				player.direction="right"
				player.state="walk"
		player.overrideWalking=true
		GameManager.respawnSpot=Vector2(global_position.x, global_position.y+1)
		var tween=create_tween()
		tween.tween_property(player, "global_position", Vector2(global_position.x, global_position.y+1), .5)
		await tween.finished
		match direction:
			directions.Front:
				player.sprite.play("down-idle")
				player.direction="down"
				player.state="idle"
			directions.Right:
				player.sprite.play("right-idle")
				player.direction="right"
				player.state="idle"
			directions.Left:
				player.sprite.play("left-idle")
				player.direction="left"
				player.state="idle"
		player.overrideWalking=false
		await get_tree().create_timer(.5).timeout
		var tween2=create_tween()
		tween2.tween_property($Dark/ColorRect, "color:a", 1, .4)
		await tween2.finished
		$Heal.play()
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
