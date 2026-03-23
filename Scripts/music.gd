extends Node2D


func battle():
	$Music.stream_paused=true
	$Battle.play()
	
func trainer():
	$Music.stream_paused=true
	$Trainer.play()
	
func battleEnded():
	$Battle.stop()
	$Trainer.stop()
	$Music.stream_paused=false
	
