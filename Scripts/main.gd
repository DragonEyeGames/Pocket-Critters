extends Node2D

@export var pokemonEncounters: Array[GameManager.pokemon] = []
@export var levelMin: int
@export var levelMax: int
@export var pokemonCenter: String
@export var pokeMart: String
var pokeCenterEntered=false
var pokeMartEntered
var season=1

@export var walls: TileMapLayer
@export var floors: TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var all_nodes = get_all_nodes(get_tree().root)
	for node in all_nodes:
		if(node is Node2D):
			node.global_position=round(node.global_position)
	GameManager.safe=true
	GameManager.encounterList=pokemonEncounters
	GameManager.encounterMin=levelMin
	GameManager.encounterMax=levelMax
	GameManager.transitionAnimator=$Transition/AnimationPlayer
	#pass
	for newPokemon in GameManager.playerTeam:
		if(newPokemon.base.evolution!=null and newPokemon.level>=newPokemon.base.evolution.level):
			GameManager.evolvePokemon(newPokemon, newPokemon.base.evolution.into)
			
	if(is_inside_tree()):
		await get_tree().process_frame
	if(is_inside_tree()):
		await get_tree().process_frame
	if(is_inside_tree()):
		GameManager.currentScene=get_tree().current_scene.scene_file_path
		await get_tree().create_timer(.1).timeout
	GameManager.safe=false

func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Interact") and pokeCenterEntered):
		get_tree().call_deferred("change_scene_to_file", pokemonCenter)
	if(Input.is_action_just_pressed("Interact") and pokeMartEntered):
		get_tree().call_deferred("change_scene_to_file", pokeMart)
	if(Input.is_action_just_pressed("SeasonSwap")):
		var newSeason = season+1
		if(season==4):
			newSeason=1
		swap_season(floors, season, newSeason)
		swap_season(walls, season, newSeason)
		season=newSeason


func _on_poke_center_area_entered(_area: Area2D) -> void:
	pokeCenterEntered=true

func _on_poke_center_area_exited(_area: Area2D) -> void:
	pokeCenterEntered=false

func _on_poke_mart_area_entered(_area: Area2D) -> void:
	pokeMartEntered=true


func _on_poke_mart_area_exited(_area: Area2D) -> void:
	pokeMartEntered=false

func swap_season(tilemap: TileMapLayer, from_source: int, to_source: int):
	for cell in tilemap.get_used_cells():
		var source_id = tilemap.get_cell_source_id(cell)
		
		if source_id == from_source:
			var atlas = tilemap.get_cell_atlas_coords(cell)
			var alt = tilemap.get_cell_alternative_tile(cell)
			
			tilemap.set_cell(cell, to_source, atlas, alt)

func get_all_nodes(node: Node) -> Array:
	var nodes = [node]
	for child in node.get_children():
		nodes += get_all_nodes(child)
	return nodes
