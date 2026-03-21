extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	visible=Input.is_action_pressed("stats")
	$Player/VBoxContainer/Attack.text=str("Attack: " + str($"../Player".attack))
	$Player/VBoxContainer/Defense.text=str("Defense: " + str($"../Player".defense))
	$Player/VBoxContainer/SpecialAttack.text=str("Sp Attack: " + str($"../Player".specialAttack))
	$Player/VBoxContainer/SpecialDefense.text=str("Sp Defense: " + str($"../Player".specialDefense))
	$Player/VBoxContainer/Speed.text=str("Speed: " + str($"../Player".speed))
	$Player/VBoxContainer/Accuracy.text=str("Accuracy: " + str($"../Player".accuracy))
	
	$Opponent/VBoxContainer/Attack.text=str("Attack: " + str($"../Opponent".attack))
	$Opponent/VBoxContainer/Defense.text=str("Defense: " + str($"../Opponent".defense))
	$Opponent/VBoxContainer/SpecialAttack.text=str("Sp Attack: " + str($"../Opponent".specialAttack))
	$Opponent/VBoxContainer/SpecialDefense.text=str("Sp Defense: " + str($"../Opponent".specialDefense))
	$Opponent/VBoxContainer/Speed.text=str("Speed: " + str($"../Opponent".speed))
	$Opponent/VBoxContainer/Accuracy.text=str("Accuracy: " + str($"../Opponent".accuracy))
