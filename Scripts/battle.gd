extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Opponent.pokemon=GameManager.toBattle
	$Opponent.initialize()
	$Player.pokemon=GameManager.playerTeam[0]
	$Player.initialize()
	$BattleOptions/Display.text="What will " + str(GameManager.playerTeam[0].name) + " do?"

func _on_run_pressed() -> void:
	GameManager.toMain()


func _on_catch_pressed() -> void:
	if(len(GameManager.playerTeam)<=5):
		GameManager.playerTeam.append(GameManager.toBattle)
		GameManager.toMain()


func _on_fight_pressed() -> void:
	$BattleOptions/Options.visible=false
	$BattleOptions/Moves.loadMoves(GameManager.playerTeam[0].moves)


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
		attack(playerAttack, $Opponent, $Player)
		await get_tree().create_timer(1).timeout
		if($Opponent.pokemon.health>0):
			attack($Opponent.randomAttack(), $Player, $Opponent)
			await get_tree().create_timer(1).timeout
		if($Opponent.pokemon.health<=0):
			var xp = 50 * $Opponent.pokemon.level / 5
			$Player.pokemon.xp+=xp
			loadLevel($Player.pokemon)
			GameManager.toMain()
		if($Player.pokemon.health<=0):
			$Player.pokemon.health=$Player.pokemon.maxHealth
			GameManager.toMain()
	else:
		attack($Opponent.randomAttack(), $Player, $Opponent)
		await get_tree().create_timer(1).timeout
		if($Player.pokemon.health>0):
			attack(playerAttack, $Opponent, $Player)
			await get_tree().create_timer(1).timeout
		if($Opponent.pokemon.health<=0):
			var xp = 50 * $Opponent.pokemon.level / 5
			$Player.pokemon.xp+=xp
			loadLevel($Player.pokemon)
			GameManager.toMain()
		if($Player.pokemon.health<=0):
			$Player.pokemon.health=$Player.pokemon.maxHealth
			GameManager.toMain()
	$BattleOptions/Options.visible=true
	
func attack(move, target, user):
	if(GameManager.moveTypes.keys()[move.moveType]=="Physical"):
		var newAttack = float(user.pokemon.attack)
		var defense = float(target.pokemon.defense)
		var power = float(move.power)

		target.pokemon.health-=round((newAttack / defense) * (power / 10.0) + 1)
		target.initialize()
		
func loadLevel(p: PokemonData):
	var backupLevel=p.level
	var newLevel=GameManager.get_level_from_xp(p.xp)
	print("old: " + str(backupLevel))
	print("new: " + str(newLevel))
	print("xp: " + str(p.xp))
	print("xp needed: " + str(GameManager.get_xp_for_level(p.level+1)-p.xp))
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
