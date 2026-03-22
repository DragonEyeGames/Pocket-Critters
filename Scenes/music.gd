extends Node2D


func battle():
	$Music.stream_paused=true
	$Battle.play()
	
func battleEnded():
	$Battle.stop()
	$Music.stream_paused=false
	
