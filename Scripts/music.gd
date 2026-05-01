extends Node2D

func closeMenu():
	print("close")
	var tween=create_tween()
	tween.tween_property($Menu, "volume_db", -80, 1)
	#$Menu.stop()
	$Music.volume_db=-80
	$Music.play()
	var tween2=create_tween()
	tween2.tween_property($Music, "volume_db", -20, .5)
	
func openMenu():
	print("open")
	var tween=create_tween()
	tween.tween_property($Music, "volume_db", -80, 1)
	#$Menu.stop()
	$Menu.volume_db=-80
	$Menu.play()
	var tween2=create_tween()
	tween2.tween_property($Menu, "volume_db", -20, .5)

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
