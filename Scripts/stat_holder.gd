extends Control
class_name StatBlock
@export var pokemonName: String
@export var level: int
@export var health: int
@export var maxHealth: int
@export var type1: GameManager.types
@export var type2: GameManager.types
func initialize():
	$Name.text=pokemonName
	$Level.text="Lv: " + str(level)
	$Health.text = str(health) + "/" + str(maxHealth)
	$Type1/AnimationPlayer.play(str(GameManager.types.keys()[type1]))
	$Type2/AnimationPlayer.play(str(GameManager.types.keys()[type2]))
