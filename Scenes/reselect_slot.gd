extends Control

@export var index:= 0
@export var bigBoss: Node

func initialize():
	if(len(GameManager.playerTeam)-1>=index):
		visible=true
		$TeamSlot.index=index
		$TeamSlot.loadSlot()
		$Select.visible=!bigBoss.activeIndex==index
	else:
		visible=false


func _on_select_pressed() -> void:
	bigBoss.activeIndex=index
	bigBoss.loadField()
	bigBoss.close()
	bigBoss.nonAttack()
