extends CanvasLayer

@export var pokemon: PokemonData
@export var names: Array[String]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=false
	#rename(GameManager.playerTeam[1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Choose.disabled=$LineEdit.text.length()==0
	
func initialize():
	get_tree().paused=true
	visible=true
	$LineEdit.text=""
	


func _on_choose_pressed() -> void:
	GameManager.playerName=$LineEdit.text
	get_tree().paused=false
	visible=false


func _on_random_pressed() -> void:
	$LineEdit.text=names.pick_random()
