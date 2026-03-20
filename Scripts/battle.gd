extends Node2D

var activeIndex=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Opponent.pokemon=GameManager.toBattle
	$Opponent.initialize()
	loadField()
	
func loadField():
	$Player.pokemon=GameManager.playerTeam[activeIndex]
	$Player.initialize()
	$BattleOptions/Display.text="What will " + str(GameManager.playerTeam[activeIndex].name) + " do?"

func _on_run_pressed() -> void:
	GameManager.toMain()


func _on_catch_pressed() -> void:
	$BattleOptions/Options.visible=false
	$BattleOptions/Display.text="Threw a ball at " + $Opponent.pokemon.name + "!"
	print(GameManager.get_catch_chance($Opponent.pokemon, 1))
	if(randf()<=GameManager.get_catch_chance($Opponent.pokemon, 1)):
		$Catch.play("catch-succeed")
		await get_tree().create_timer(2).timeout
		if(len(GameManager.playerTeam)<=5):
			GameManager.playerTeam.append(GameManager.toBattle)
			$BattleOptions/Display.text="Caught it! " + $Opponent.pokemon.name + " Has been caught!"
			$Opponent.visible=false
			await get_tree().create_timer(3).timeout
			GameManager.toMain()
			return
	else:
		$Catch.play("catch-fail")
		await get_tree().create_timer(2).timeout
		$BattleOptions/Display.text="Aww man! " + $Opponent.pokemon.name + " Broke out!"
		await get_tree().create_timer(1).timeout
	nonAttack()


func _on_fight_pressed() -> void:
	$BattleOptions/Options.visible=false
	$BattleOptions/Moves.loadMoves(GameManager.playerTeam[activeIndex].moves)


func _on_move1_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move.move)


func _on_move_2_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move2.move)


func _on_move_3_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move3.move)


func _on_move_4_pressed() -> void:
	loadAttack($BattleOptions/Moves/Move4.move)
	
func loadAttack(playerAttack):
	$BattleOptions/Moves.visible=false
	if($Player.pokemon.speed>=$Opponent.pokemon.speed):
		await attack(playerAttack, $Opponent, $Player)
		if($Opponent.pokemon.health>0):
			await attack($Opponent.randomAttack(), $Player, $Opponent)
		if($Opponent.pokemon.health<=0):
			var xp = 50 * $Opponent.pokemon.level / 5
			$Player.pokemon.xp+=xp
			loadLevel($Player.pokemon)
			GameManager.toMain()
			return
		if($Player.pokemon.health<=0):
			$Player.pokemon.health=$Player.pokemon.maxHealth
			GameManager.toMain()
			return
	else:
		await attack($Opponent.randomAttack(), $Player, $Opponent)
		if($Player.pokemon.health>0):
			await attack(playerAttack, $Opponent, $Player)
		if($Opponent.pokemon.health<=0):
			var xp = 50 * $Opponent.pokemon.level / 5
			$Player.pokemon.xp+=xp
			loadLevel($Player.pokemon)
			GameManager.toMain()
			return
		if($Player.pokemon.health<=0):
			$Player.pokemon.health=$Player.pokemon.maxHealth
			GameManager.toMain()
			return
	$BattleOptions/Display.text="What will " + str(GameManager.playerTeam[activeIndex].name) + " do?"
	$BattleOptions/Options.visible=true
	
func attack(move, target, user):
	$BattleOptions/Display.text=str(user.pokemon.name) + " used " + str(move.name)
	await get_tree().create_timer(1).timeout
	if(randf()<=move.accuracy):
		if(GameManager.moveTypes.keys()[move.moveType]=="Physical"):
			var newAttack = float(user.pokemon.attack)
			var defense = float(target.pokemon.defense)
			var power = float(move.power)
			var multiplier = GameManager.get_type_multiplier(GameManager.types.keys()[move.type], GameManager.types.keys()[target.pokemon.base.type1], GameManager.types.keys()[target.pokemon.base.type2])
			target.pokemon.health-=round(((newAttack / defense) * (power / 10.0) + 1) * multiplier)
			target.initialize()
			print(multiplier)
			if(multiplier>1):
				$BattleOptions/Display.text="It's super effective!"
			elif(multiplier<1):
				$BattleOptions/Display.text="It's not very effective..."
			elif(multiplier==0):
				$BattleOptions/Display.text="It had no effect"
			else:
				$BattleOptions/Display.text=""
		if(GameManager.moveTypes.keys()[move.moveType]=="Special"):
			var newAttack = float(user.pokemon.specialAttack)
			var defense = float(target.pokemon.specialDefense)
			var power = float(move.power)
			var multiplier = GameManager.get_type_multiplier(GameManager.types.keys()[move.type], GameManager.types.keys()[target.pokemon.base.type1], GameManager.types.keys()[target.pokemon.base.type2])
			target.pokemon.health-=round(((newAttack / defense) * (power / 10.0) + 1) * multiplier)
			target.initialize()
			print(multiplier)
			if(multiplier>1):
				$BattleOptions/Display.text="It's super effective!"
			elif(multiplier<1):
				$BattleOptions/Display.text="It's not very effective..."
			elif(multiplier==0):
				$BattleOptions/Display.text="It had no effect"
			else:
				$BattleOptions/Display.text=""
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
	if($Player.pokemon.health<=0):
		$Player.pokemon.health=$Player.pokemon.maxHealth
		GameManager.toMain()
	$BattleOptions/Options.visible=true
