extends Control

@export var index=1
@export var overwriteSlot:=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible=true
	if FileAccess.file_exists("user://save-" + str(index) + ".tres"):
		var data = load("user://save-" + str(index) + ".tres") as GameData
		$Critter/TeamSlot.loadPokemon(data.team.team[0])
		$TimePlayed/Time.text=str(loadTime(data.playtime))
		$PlayerName/Name.text=data.playerName
		if(overwriteSlot):
			$loadSave.text="Overwrite"
	else:
		visible=false

func loadTime(seconds: float):
	var total = int(seconds)

	var hours = int(total / 3600.0)
	var minutes = int((total % 3600) / 60.0)

	return str(hours).pad_zeros(1) + ":" + str(minutes).pad_zeros(2)


func _on_load_save_pressed() -> void:
	Music.closeMenu()
	GameManager.loadedSave=index
	if(overwriteSlot):
		GameManager.wipeSave()
	else:
		GameManager.initialize()
