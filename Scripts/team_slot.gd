extends Control

@export var index:= 0
var mouse=false
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
	

func _process(_delta: float) -> void:
	if(mouse and Input.is_action_just_pressed("Interact")):
		$OptionsMenu.visible=true
		$MouseDetector.visible=false

func mouseEntered() -> void:
	var tween=create_tween()
	tween.tween_property($Pokemon, "scale", Vector2(1.1, 1.1), .1)
	mouse=true


func mouseExited() -> void:
	var tween=create_tween()
	tween.tween_property($Pokemon, "scale", Vector2(1, 1), .1)
	mouse=false

func buttonPress(nodeName: String):
	if(nodeName=="Close"):
		$OptionsMenu.visible=false
		$MouseDetector.visible=true
	if(nodeName=="Stats"):
		Stats.displayStats(GameManager.playerTeam[index])
	if(nodeName=="Critterdex"):
		Info.display(GameManager.playerTeam[index])
