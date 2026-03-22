extends Control
class_name StatBlock
@export var pokemonName: String
@export var level: int
@export var health: int
@export var maxHealth: int
@export var type1: GameManager.types
@export var type2: GameManager.types

func initialize(refreshed):
	if(refreshed):
		$"Health Bar".max_value=maxHealth
		$"Health Bar".value=health
		$"Health Bar/Health Bar2".max_value=maxHealth
		$"Health Bar/Health Bar2".value=health
	$Name.text=pokemonName
	$Level.text="Lv: " + str(level)
	$"Health Bar/Health".text = str(health) + "/" + str(maxHealth)
	$"Health Bar".max_value=maxHealth
	$"Health Bar/Health Bar2".max_value=maxHealth
	var tween=create_tween()
	tween.tween_property($"Health Bar", "value", health, .2)
	var tween2=create_tween()
	tween2.tween_property($"Health Bar/Health Bar2", "value", health, .5)
	#$"Health Bar".value=health
	$Type1/AnimationPlayer.play(str(GameManager.types.keys()[type1]))
	$Type2/AnimationPlayer.play(str(GameManager.types.keys()[type2]))

func xp(old, new, newPokemon):
	$"XP-Bar".visible = true
	
	var current_xp = old
	var current_level = GameManager.get_level_from_xp(current_xp)

	while current_xp < new:
		current_xp += 1
		newPokemon.xp+=1
		
		
		var level_start = GameManager.get_xp_for_level(current_level)
		var level_end = GameManager.get_xp_for_level(current_level + 1)
		
		$"XP-Bar".max_value = level_end - level_start
		$"XP-Bar".value = current_xp - level_start
		
		$"XP-Bar/XP".text = str(int($"XP-Bar".value)) + "/" + str(int($"XP-Bar".max_value))
		
		# Check for level up
		var new_level_check = GameManager.get_level_from_xp(current_xp)
		if new_level_check > current_level:
			current_level = new_level_check
			newPokemon.level+=1
			$"..".loadLevel(newPokemon)
			$"../Player".initialize()
			$"../BattleOptions/Display".text=newPokemon.name + " leveled up to level " + str(newPokemon.level) + "!"
			await get_tree().create_timer(2).timeout
			$"../BattleOptions/Display".text=""
			# Reset bar visually (next loop will refill correctly)
			await get_tree().create_timer(0.2).timeout
		
		await get_tree().create_timer(0.01).timeout
	
	await get_tree().create_timer(1).timeout
	$"XP-Bar".visible = false
