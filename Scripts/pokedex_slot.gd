extends Control

@export var pokemon: GameManager.pokemon

var mouseHovering := false

func initialize():
	$Pokemon.pokemon=pokemon
	$Pokemon.initialize()
	if(pokemon in GameManager.pokedex):
		$Pokemon.modulate=Color.WHITE
	elif(pokemon in GameManager.seenDex):
		$Pokemon.modulate=Color.DIM_GRAY
	else:
		$Pokemon.modulate=Color.BLACK

func _process(_delta: float) -> void:
	if(mouseHovering and Input.is_action_just_pressed("Interact")):
		Info.loadFromEnum(pokemon)

func mouseEntered() -> void:
	var tween = create_tween()
	tween.tween_property($Pokemon, "scale", Vector2(1.25, 1.25), .1)
	mouseHovering=true

func mouseExited() -> void:
	var tween = create_tween()
	tween.tween_property($Pokemon, "scale", Vector2(1.1, 1.1), .1)
	mouseHovering=false
