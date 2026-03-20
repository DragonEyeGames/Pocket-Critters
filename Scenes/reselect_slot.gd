extends Control

@export var index:= 0
@export var bigBoss: Node

func initialize():
	if(len(GameManager.playerTeam)-1>=index):
		visible=true
		$TeamSlot.index=index
		$TeamSlot.loadSlot()
		if(not bigBoss.deadPokemon):
			$Select.visible=!bigBoss.activeIndex==GameManager.healthyTeam.find(GameManager.playerTeam[index])
		else:
			$Select.visible=true
		if(GameManager.playerTeam[index].health<=0):
			$Select.visible=false
	else:
		visible=false


func _on_select_pressed() -> void:
	bigBoss.activeIndex=GameManager.healthyTeam.find(GameManager.playerTeam[index])
	bigBoss.loadField()
	bigBoss.close()
	if(not bigBoss.deadPokemon):
		bigBoss.nonAttack()
	else:
		bigBoss.undeadPokemon()
		
