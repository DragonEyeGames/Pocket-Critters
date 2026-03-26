extends Node2D


func battle():
	$Music.stream_paused=true
	$Battle.volume_db=-20
	$Trainer.volume_db=-13
	$Battle.play()
	
func trainer():
	$Music.stream_paused=true
	$Battle.volume_db=-20
	$Trainer.volume_db=-13
	$Trainer.play()
	
func battleEnded():
	$Battle.stop()
	$Trainer.stop()
	$Music.stream_paused=false
	
func battleOver():
	var tween=create_tween()
	tween.tween_property($Battle, "volume_db", -40, .5)
	var tween2=create_tween()
	tween2.tween_property($Trainer, "volume_db", -40, .5)
	$BattleWon.play()
	
func evolve():
	$Battle.stop()
	$Trainer.stop()
	$Music.stream_paused=true
	$Evolve.play()
