extends Control

@export var index:= 0
var mouse=false
# Called when the node enters the scene tree for the first time.

func loadPokemon(pokemon: PokemonData):
	$Name/Name.text=str(pokemon.name)
	fitText()
	$Pokemon.pokemon=pokemon
	$Pokemon.initialize()
	$Pokemon.scale*=1.2
	

func fitText():
	var font = $Name/Name.get_theme_font("font")
	var sizes = 16  # your pixel font size

	var text_width = font.get_string_size($Name/Name.text, HORIZONTAL_ALIGNMENT_LEFT, -1, sizes).x
	var text_height = font.get_height(sizes)
	var widthPercent = 100/text_width
	var heightPercent = 34/text_height
	var largestVal = min(widthPercent, heightPercent)
	largestVal/=.9
	$Name/Name.scale=Vector2(largestVal, largestVal)
	#$Name.scale = Vector2(text_width + 20, text_height + 10)

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
