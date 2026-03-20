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
	attack($BattleOptions/Moves/Move.move, $Opponent, $Player)
	attack($Opponent.randomAttack(), $Player, $Opponent)


func _on_move_2_pressed() -> void:
	attack($BattleOptions/Moves/Move2.move, $Opponent, $Player)
	attack($Opponent.randomAttack(), $Player, $Opponent)


func _on_move_3_pressed() -> void:
	attack($BattleOptions/Moves/Move3.move, $Opponent, $Player)
	attack($Opponent.randomAttack(), $Player, $Opponent)


func _on_move_4_pressed() -> void:
	attack($BattleOptions/Moves/Move4.move, $Opponent, $Player)
	attack($Opponent.randomAttack(), $Player, $Opponent)
	
func attack(move, target, user):
	print(move.moveType)
	print(GameManager.moveTypes.keys()[move.moveType])
	if(GameManager.moveTypes.keys()[move.moveType]=="Physical"):
		print(target.pokemon.defense)
		print(user.pokemon.attack)
		print(move.power)
		var newAttack = float(user.pokemon.attack)
		var defense = float(target.pokemon.defense)
		var power = float(move.power)

		print(round((newAttack / defense) * (power / 10.0)) + 1)
		target.pokemon.health-=round((newAttack / defense) * (power / 10.0) + 1)
		target.initialize()
