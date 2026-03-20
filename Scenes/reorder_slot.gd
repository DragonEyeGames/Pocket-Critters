extends Control

@export var index:= 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TeamSlot.index=index


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	visible=len(GameManager.playerTeam)-1>=index
