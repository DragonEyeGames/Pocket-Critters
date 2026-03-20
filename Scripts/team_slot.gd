extends Control

@export var index:= 0
# Called when the node enters the scene tree for the first time.

func loadSlot():
	if(len(GameManager.playerTeam)-1>=index):
		$Name.text=str(GameManager.playerTeam[index].name)
		$Pokemon.pokemon=GameManager.playerTeam[index]
		print(index)
		$Pokemon.initialize()
	else:
		$Pokemon.visible=false
		$Name.visible=false
	
