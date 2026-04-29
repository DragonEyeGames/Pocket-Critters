extends Control

@export var index:= 0
@export var bigBoss: Node

func _ready() -> void:
	initialize()

func initialize():
	if(len(GameManager.playerTeam)-1>=index):
		visible=true
		var pokemon: PokemonData = GameManager.playerTeam[index]
		$NewPokemon.pokemon=pokemon.species
		$NewPokemon.initialize()
		$Name.text=pokemon.name
		$"Health Bar".value=pokemon.health
		$"Health Bar".max_value=pokemon.maxHealth
		$"Health Bar/Health".text=str(pokemon.health) + "/" + str(pokemon.maxHealth)
		$Button.disabled=(pokemon.health<=0 or bigBoss.activeIndex==index)
		$Fainted.visible=pokemon.health<=0
		fitText()
	else:
		visible=false

func fitText():
	var font = $Name.get_theme_font("font")
	var sizes = 16  # your pixel font size

	var text_width = font.get_string_size($Name.text, HORIZONTAL_ALIGNMENT_LEFT, -1, sizes).x
	var text_height = font.get_height(sizes)
	var widthPercent = 106/text_width
	var heightPercent = 18/text_height
	var largestVal = min(widthPercent, heightPercent)
	largestVal/=.9
	$Name.scale=Vector2(largestVal, largestVal)
	#$Name.scale = Vector2(text_width + 20, text_height + 10)


func _on_select_pressed() -> void:
	bigBoss.replacePokemon(index)
