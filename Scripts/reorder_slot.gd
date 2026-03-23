extends Control

@export var index:= 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TeamSlot.index=index


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	visible=len(GameManager.playerTeam)-1>=index
	
func initialize():
	if(index==0):
		$Up.visible=false
	$Down.visible = (len(GameManager.playerTeam)>index+1)
	$TeamSlot.loadSlot()


func _on_down_pressed() -> void:
	var temp = GameManager.playerTeam[index]
	GameManager.playerTeam[index] = GameManager.playerTeam[index+1]
	GameManager.playerTeam[index+1]=temp
	for child in get_parent().get_children():
		child.initialize()


func _on_up_pressed() -> void:
	var temp = GameManager.playerTeam[index]
	GameManager.playerTeam[index] = GameManager.playerTeam[index-1]
	GameManager.playerTeam[index-1]=temp
	for child in get_parent().get_children():
		child.initialize()
	for child in $"../../../Team Menu/GridContainer".get_children():
		child.loadSlot()
