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

	var duration = 3.0
	var elapsed = 0.0

	var start_xp = old
	var end_xp = new

	var current_level = GameManager.get_level_from_xp(start_xp)

	while elapsed < duration:
		await get_tree().process_frame
		var delta = get_process_delta_time()
		elapsed += delta

		var t = elapsed / duration
		var current_xp = lerp(start_xp, end_xp, t)

		newPokemon.xp = int(current_xp)

		var level_start = GameManager.get_xp_for_level(current_level)
		var level_end = GameManager.get_xp_for_level(current_level + 1)

		$"XP-Bar".max_value = level_end - level_start
		$"XP-Bar".value = current_xp - level_start

		$"XP-Bar/XP".text = str(int($"XP-Bar".value)) + "/" + str(int($"XP-Bar".max_value))

		var new_level_check = GameManager.get_level_from_xp(current_xp)
		if new_level_check > current_level:
			current_level = new_level_check
			newPokemon.level += 1

			$LevelUp.play()
			$"..".loadLevel(newPokemon)
			$"../Player".initialize()

			$"../BattleOptions/Display".text = newPokemon.name + " leveled up to level " + str(newPokemon.level) + "!"
			await get_tree().create_timer(2).timeout
			$"../BattleOptions/Display".text = ""

	# Ensure final values are exact
	newPokemon.xp = end_xp
	await get_tree().create_timer(.2).timeout
	$"XP-Bar".visible = false
