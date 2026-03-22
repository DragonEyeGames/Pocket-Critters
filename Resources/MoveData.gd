extends Resource
class_name MoveDatas

@export var name: String = ""
@export var type: GameManager.types
@export var moveType: GameManager.moveTypes
@export var power: int = 50
@export var accuracy: float = 1.0
@export var abilities: Array[AbilityData] = []

@export var soundPath: String
