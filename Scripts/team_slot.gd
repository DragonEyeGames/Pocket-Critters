extends Control

@export var index:= 0
# Called when the node enters the scene tree for the first time.

func loadSlot():
	if(len(GameManager.playerTeam)-1>=index):
		$Name.text=str(GameManager.playerTeam[index].name)
		$Pokemon.pokemon=GameManager.playerTeam[index]
		$Fainted.visible=GameManager.playerTeam[index].health<=0
		$Pokemon.initialize()
		$"Health Bar".max_value=GameManager.playerTeam[index].maxHealth
		$"Health Bar".value=GameManager.playerTeam[index].health
		$"Health Bar/Health".text=str(GameManager.playerTeam[index].health) + "/" + str(GameManager.playerTeam[index].maxHealth)
	else:
		$Pokemon.visible=false
		$Name.visible=false
		$Fainted.visible=false
		$"Health Bar".visible=false
	
