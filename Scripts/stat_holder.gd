extends ColorRect
class_name StatBlock
@export var pokemonName: String
@export var level: int
@export var health: int
@export var maxHealth: int

func initialize():
	$Name.text=pokemonName
	$Level.text="Lv: " + str(level)
	$Health.text = str(health) + "/" + str(maxHealth)
