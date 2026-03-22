extends Node2D

@export var back:=false
@export var pokemon: PokemonData
@export var holder: StatBlock

@export var attack=0
@export var defense=0
@export var specialAttack=0
@export var specialDefense=0
@export var speed=0
@export var accuracy=0

var backupPokemon=null

# Called when the node enters the scene tree for the first time.
func initialize() -> void:
	var refresh=false
	if(backupPokemon!=pokemon):
		attack=0
		defense=0
		specialAttack=0
		specialDefense=0
		speed=0
		accuracy=0
		backupPokemon=pokemon
		print("refreshed stats")
		if has_node("Appear"):
			get_node("Appear").play("spawn")
		refresh=true
	for child in $Back.get_children():
		child.visible=false
	for child in $Front.get_children():
		child.visible=false
	if(back):
		for child in $Back.get_children():
			child.visible=false
			if(child.name==str(GameManager.pokemonName(pokemon.species))):
				child.visible=true
	elif(!back):
		for child in $Front.get_children():
			child.visible=false
			if(child.name==str(GameManager.pokemonName(pokemon.species))):
				child.visible=true
	
	if(holder!=null):
		holder.pokemonName=str(GameManager.pokemonName(pokemon.species))
		holder.type1=pokemon.base.type1
		holder.type2=pokemon.base.type2
		holder.level=pokemon.level
		holder.health=pokemon.health
		holder.maxHealth=pokemon.maxHealth
		if(pokemon.health<=0):
			var tween=create_tween()
			tween.tween_property(self, "scale", Vector2.ZERO, .15)
			holder.health=0
			pokemon.health=0
		else:
			scale=Vector2(3, 3)
		holder.initialize(refresh)
			
func randomAttack():
	return(pokemon.moves.pick_random())

func xp(old, new):
	await holder.xp(old, new, pokemon)

func cry():
	if(pokemon.base.cryPath==""):
		return
	get_node("Animate").play("call")
	var player = AudioStreamPlayer.new()
	player.stream = load(pokemon.base.cryPath)
	player.volume_db=-10
	add_child(player)
	player.play()
	
	await player.finished
	player.queue_free()
