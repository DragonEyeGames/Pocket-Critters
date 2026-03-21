extends Node2D

var activeIndex=0
var deadPokemon=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(GameManager.teamBattle):
		$BattleOptions/Options/Catch.disabled=true
		$BattleOptions/Options/Run.disabled=true
	var healthy : Array[PokemonData] = []
	var fainted: Array[PokemonData] =[]
	for pokemon in GameManager.playerTeam:
		if(pokemon.health>0):
			healthy.append(pokemon)
		else:
			fainted.append(pokemon)
	if(len(healthy)>=1):
		GameManager.healthyTeam = healthy
	else:
		get_tree().change_scene_to_file("res://Scenes/dead.tscn")
		return
	$Opponent.pokemon=GameManager.toBattle
	GameManager.seenDex.append(GameManager.toBattle.species)
	$Opponent.initialize()
	loadField()
	
func loadField():
	$Player.pokemon=GameManager.healthyTeam[activeIndex]
	$Player.initialize()
	$BattleOptions/Display.text="What will " + str(GameManager.healthyTeam[activeIndex].name) + " do?"

func _on_run_pressed() -> void:
	GameManager.toMain()


func _on_catch_pressed() -> void:
	$BattleOptions/Options.visible=false
	$BattleOptions/Display.text="Threw a ball at " + $Opponent.pokemon.name + "!"
	print(GameManager.get_catch_chance($Opponent.pokemon, 1))
	if(randf()<=GameManager.get_catch_chance($Opponent.pokemon, 1)):
		$Catch.play("catch-succeed")
		await get_tree().create_timer(2).timeout
		$BattleOptions/Display.text="Caught it! " + $Opponent.pokemon.name + " has been caught!"
		$Opponent.visible=false
		GameManager.pokedex.append($Opponent.pokemon.species)
		if(len(GameManager.playerTeam)<=5):
			GameManager.playerTeam.append(GameManager.toBattle)
			await get_tree().create_timer(3).timeout
			GameManager.toMain()
			return
		else:
			$"Replace Team".visible=true
			for child in $"Replace Team/GridContainer".get_children():
				child.initialize()
		return
	else:
		$Catch.play("catch-fail")
		await get_tree().create_timer(2).timeout
		$BattleOptions/Display.text="Aww man! " + $Opponent.pokemon.name + " Broke out!"
		await get_tree().create_timer(1).timeout
		nonAttack()


func _on_fight_pressed() -> void:
	$BattleOptions/Options.visible=false
	$BattleOptions/Moves.loadMoves(GameManager.healthyTeam[activeIndex].moves)


func _on_move1_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move.move)


func _on_move_2_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move2.move)


func _on_move_3_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move3.move)


func _on_move_4_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move4.move)
	
func loadAttack(playerAttack):
	var opponentAttack = $Opponent.randomAttack()
	$BattleOptions/Moves.visible=false
	var playerSpeed=$Player.pokemon.speed * GameManager.get_stage_multiplier($Player.speed)
	if(len(playerAttack.abilities)>=1):
		for ability in playerAttack.abilities:
			if(ability.stat==GameManager.stats.Priority):
				playerSpeed+=1000
	var opponentSpeed=$Opponent.pokemon.speed * GameManager.get_stage_multiplier($Opponent.speed)
	if(len(opponentAttack.abilities)>=1):
		for ability in opponentAttack.abilities:
			if(ability.stat==GameManager.stats.Priority):
				opponentSpeed+=1000
	if(playerSpeed>=opponentSpeed):
		await attack(playerAttack, $Opponent, $Player)
		if($Opponent.pokemon.health>0):
			await attack(opponentAttack, $Player, $Opponent)
		if($Opponent.pokemon.health<=0):
			var xp = 50 * $Opponent.pokemon.level / 5
			$Player.pokemon.xp+=xp
			loadLevel($Player.pokemon)
			if(!GameManager.teamBattle):
				GameManager.toMain()
			else:
				teamBattleDead()
			return
		if(!checkPlayer()):
			return
	else:
		await attack(opponentAttack, $Player, $Opponent)
		if($Player.pokemon.health>0):
			await attack(playerAttack, $Opponent, $Player)
		if($Opponent.pokemon.health<=0):
			var xp = 50 * $Opponent.pokemon.level / 5
			$Player.pokemon.xp+=xp
			loadLevel($Player.pokemon)
			if(!GameManager.teamBattle):
				GameManager.toMain()
			else:
				teamBattleDead()
			return
		if(!checkPlayer()):
			return
	$BattleOptions/Display.text="What will " + str(GameManager.healthyTeam[activeIndex].name) + " do?"
	$BattleOptions/Options.visible=true
	
func attack(move, target, user):
	$BattleOptions/Display.text=str(user.pokemon.name) + " used " + str(move.name)
	await get_tree().create_timer(1).timeout
	if(randf()<=(move.accuracy * GameManager.get_stage_multiplier(user.accuracy))):
		if(GameManager.moveTypes.keys()[move.moveType]=="Physical"):
			var newAttack = float(user.pokemon.attack)
			newAttack *= GameManager.get_stage_multiplier(user.attack)
			var defense = float(target.pokemon.defense)
			defense*=GameManager.get_stage_multiplier(target.defense)
			var power = float(move.power)
			var multiplier = GameManager.get_type_multiplier(GameManager.types.keys()[move.type], GameManager.types.keys()[target.pokemon.base.type1], GameManager.types.keys()[target.pokemon.base.type2])
			var stab = 1.0
			if(user.pokemon.base.type1==move.type or user.pokemon.base.type2==move.type):
				stab=1.5
			var damage = round(((newAttack / defense) * (power / 10.0) + 1) * multiplier * stab)
			target.pokemon.health-=damage
			target.initialize()
			if(multiplier==0):
				$BattleOptions/Display.text="It had no effect"
			elif(multiplier>1):
				$BattleOptions/Display.text="It's super effective!"
			elif(multiplier<1):
				$BattleOptions/Display.text="It's not very effective..."
			else:
				$BattleOptions/Display.text=""
			await calculateAbilities(move, user, target, damage)
		if(GameManager.moveTypes.keys()[move.moveType]=="Special"):
			var newAttack = float(user.pokemon.specialAttack)
			newAttack *= GameManager.get_stage_multiplier(user.specialAttack)
			var defense = float(target.pokemon.specialDefense)
			defense*=GameManager.get_stage_multiplier(target.specialDefense)
			var power = float(move.power)
			var multiplier = GameManager.get_type_multiplier(GameManager.types.keys()[move.type], GameManager.types.keys()[target.pokemon.base.type1], GameManager.types.keys()[target.pokemon.base.type2])
			var stab = 1.0
			if(user.pokemon.base.type1==move.type or user.pokemon.base.type2==move.type):
				stab=1.5
			var damage = round(((newAttack / defense) * (power / 10.0) + 1) * multiplier * stab)
			target.pokemon.health-=damage
			target.initialize()
			if(multiplier==0):
				$BattleOptions/Display.text="It had no effect"
			elif(multiplier>1):
				$BattleOptions/Display.text="It's super effective!"
			elif(multiplier<1):
				$BattleOptions/Display.text="It's not very effective..."
			else:
				$BattleOptions/Display.text=""
			await calculateAbilities(move, user, target, damage)
		if(GameManager.moveTypes.keys()[move.moveType]=="Status"):
			var abilities = move.abilities.duplicate()
			while len(abilities)>=1:
				if(abilities[0].stat==GameManager.stats.Attack):
					if(abilities[0].targetsSelf):
						user.attack+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "attack", user)
						await get_tree().create_timer(1).timeout
					else:
						target.attack+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "attack", target)
						await get_tree().create_timer(1).timeout
				if(abilities[0].stat==GameManager.stats.Defense):
					if(abilities[0].targetsSelf):
						user.defense+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "defense", user)
						await get_tree().create_timer(1).timeout
					else:
						target.defense+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "defense", target)
					await get_tree().create_timer(1).timeout
				if(abilities[0].stat==GameManager.stats.SpecialAttack):
					if(abilities[0].targetsSelf):
						user.specialAttack+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special attack", user)
						await get_tree().create_timer(1).timeout
					else:
						target.specialAttack+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special attack", target)
						await get_tree().create_timer(1).timeout
				if(abilities[0].stat==GameManager.stats.SpecialDefense):
					if(abilities[0].targetsSelf):
						user.specialDefense+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special defense", user)
						await get_tree().create_timer(1).timeout
					else:
						target.specialDefense+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special defense", target)
						await get_tree().create_timer(1).timeout
				if(abilities[0].stat==GameManager.stats.Speed):
					if(abilities[0].targetsSelf):
						user.speed+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "speed", user)
						await get_tree().create_timer(1).timeout
					else:
						target.speed+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "speed", target)
				if(abilities[0].stat==GameManager.stats.Accuracy):
					if(abilities[0].targetsSelf):
						user.accuracy+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "accuracy", user)
						await get_tree().create_timer(1).timeout
					else:
						target.accuracy+=abilities[0].change
						$BattleOptions/Display.text=calculateAmount(abilities[0].change, "accuracy", target)
						await get_tree().create_timer(1).timeout
				abilities.remove_at(0)
	else:
		$BattleOptions/Display.text="But it missed!"
	await get_tree().create_timer(1).timeout
		
func loadLevel(p: PokemonData):
	var backupLevel=p.level
	var newLevel=GameManager.get_level_from_xp(p.xp)
	if(backupLevel!=newLevel):
		p.level=newLevel
		var backupHealth=p.maxHealth
		p.maxHealth=GameManager.get_stat(p.base.health, p.ivHealth, newLevel)
		p.health+=p.maxHealth-backupHealth
		p.attack=GameManager.get_stat(p.base.attack, p.ivAttack, newLevel)
		p.defense=GameManager.get_stat(p.base.defense, p.ivDefense, newLevel)
		p.specialAttack=GameManager.get_stat(p.base.specialAttack, p.ivSpecialAttack, newLevel)
		p.specialDefense=GameManager.get_stat(p.base.specialDefense, p.ivSpecialDefense, newLevel)
		p.speed=GameManager.get_stat(p.base.speed, p.ivSpeed, newLevel)


func _on_switch_pressed() -> void:
	$"Reorder Team".visible=true
	for child in $"Reorder Team/GridContainer".get_children():
		child.initialize()


func close() -> void:
	$"Reorder Team".visible=false
	
func nonAttack():
	$BattleOptions/Moves.visible=false
	$BattleOptions/Options.visible=false
	await attack($Opponent.randomAttack(), $Player, $Opponent)
	if(!checkPlayer()):
		return
	$BattleOptions/Display.text="What will " + str(GameManager.healthyTeam[activeIndex].name) + " do?"
	$BattleOptions/Options.visible=true

func replacePokemon(index: int):
	GameManager.playerTeam[index]=$Opponent.pokemon
	GameManager.toMain()

func toBoxes() -> void:
	GameManager.toMain()
	
func checkPlayer():
	if($Player.pokemon.health<=0):
		var healthy : Array[PokemonData] = []
		var fainted: Array[PokemonData] =[]
		for pokemon in GameManager.playerTeam:
			if(pokemon.health>0):
				healthy.append(pokemon)
			else:
				fainted.append(pokemon)
		if(len(healthy)>=1):
			GameManager.healthyTeam = healthy
		else:
			get_tree().change_scene_to_file("res://Scenes/dead.tscn")
			return false
		$"Reorder Team".visible=true
		$"Reorder Team/Button".visible=false
		deadPokemon=true
		for child in $"Reorder Team/GridContainer".get_children():
			child.initialize()
		return false
	return true

func undeadPokemon():
	deadPokemon=false
	$"Reorder Team/Button".visible=true
	$BattleOptions/Display.text="What will " + str(GameManager.healthyTeam[activeIndex].name) + " do?"
	$BattleOptions/Options.visible=true
	$Player.visible=true
	loadField()
	
func calculateAbilities(move, user, target, damage):
	await get_tree().create_timer(1).timeout
	var abilities = move.abilities.duplicate()
	while len(abilities)>=1:
		print(abilities[0].chance	)
		if(randf()<=abilities[0].chance):
			if(abilities[0].stat==GameManager.stats.Attack):
				if(abilities[0].targetsSelf):
					user.attack+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "attack", user)
					await get_tree().create_timer(1).timeout
				else:
					target.attack+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "attack", target)
					await get_tree().create_timer(1).timeout
			if(abilities[0].stat==GameManager.stats.Defense):
				if(abilities[0].targetsSelf):
					user.defense+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "defense", user)
					await get_tree().create_timer(1).timeout
				else:
					target.defense+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "defense", target)
					await get_tree().create_timer(1).timeout
			if(abilities[0].stat==GameManager.stats.SpecialAttack):
				if(abilities[0].targetsSelf):
					user.specialAttack+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special attack", user)
					await get_tree().create_timer(1).timeout
				else:
					target.specialAttack+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special attack", target)
					await get_tree().create_timer(1).timeout
			if(abilities[0].stat==GameManager.stats.SpecialDefense):
				if(abilities[0].targetsSelf):
					user.specialDefense+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special defense", user)
					await get_tree().create_timer(1).timeout
				else:
					target.specialDefense+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "special defense", target)
					await get_tree().create_timer(1).timeout
			if(abilities[0].stat==GameManager.stats.Speed):
				if(abilities[0].targetsSelf):
					user.speed+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "speed", user)
					await get_tree().create_timer(1).timeout
				else:
					target.speed+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "speed", target)
					await get_tree().create_timer(1).timeout
			if(abilities[0].stat==GameManager.stats.Accuracy):
				if(abilities[0].targetsSelf):
					user.accuracy+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "accuracy", user)
					await get_tree().create_timer(1).timeout
				else:
					target.accuracy+=abilities[0].change
					$BattleOptions/Display.text=calculateAmount(abilities[0].change, "accuracy", target)
					await get_tree().create_timer(1).timeout
			if(abilities[0].stat==GameManager.stats.Health):
				if(abilities[0].targetsSelf):
					user.pokemon.health+=round((float(abilities[0].change/100.0)*float(damage)))
					if(user.pokemon.health>user.pokemon.maxHealth):
						user.pokemon.health=user.pokemon.maxHealth
					$BattleOptions/Display.text=user.pokemon.name + " regained some health!"
					await get_tree().create_timer(1).timeout
					$Player.initialize()
				else:
					target.speed+=(abilities[0].change/100)*damage
					if(target.pokemon.health>target.pokemon.maxHealth):
						target.pokemon.health=user.pokemon.maxHealth
					$BattleOptions/Display.text=target.pokemon.name + " regained some health!"
					await get_tree().create_timer(1).timeout
					$Opponent.initialize()
			
		abilities.remove_at(0)

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Pause") and $BattleOptions/Moves.visible):
		$BattleOptions/Moves.visible=false
		$BattleOptions/Options.visible=true

func teamBattleDead():
	if(len(GameManager.opposingTeam)>=1):
		$BattleOptions/Display.text="Knocked out Blaze's " + $Opponent.pokemon.name + "!"
		await get_tree().create_timer(1).timeout
		$Opponent.pokemon=GameManager.opposingTeam[0]
		GameManager.opposingTeam.remove_at(0)
		$Opponent.initialize()
		$Opponent.visible=true
		$BattleOptions/Display.text="Blaze sent out " + $Opponent.pokemon.name + "!"
		await get_tree().create_timer(1).timeout
		$BattleOptions/Display.text="What will " + $Player.pokemon.name + " do?"
		$BattleOptions/Options.visible=true
		
	else:
		$BattleOptions/Display.text="Knocked out Blaze's " + $Opponent.pokemon.name + "!"
		await get_tree().create_timer(1).timeout
		$BattleOptions/Display.text="Blaze has been defeated!"
		await get_tree().create_timer(3).timeout
		GameManager.toMain()

func calculateAmount(change, newText, target):
	var amountText=" rose!"
	if(change==2):
		amountText=" rose sharply!"
	if(change==-1):
		amountText=" fell!"
	if(change==-2):
		amountText=" fell sharply!"
	return target.pokemon.name + "'s " + newText + amountText
