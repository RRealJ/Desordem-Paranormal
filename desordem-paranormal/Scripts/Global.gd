extends Node

const PLAYER_COLLISION_LAYER = 2
const ENEMY_COLLISION_LAYER = 8
const OBSTACLE_COLLISION_LAYER = 11
const RAYCAST_ENEMY_COLLISION_LAYER=  12
const TILE_SIZE = 16

var obstacle_tile_map: TileMapLayer
var pathfinder: Pathfinder

var player: CharacterBody2D
var enemies: Node2D # for Calc and Counts

var money: int = 69000
var enemies_killed: int
var items_resources_avaible: Array[Dictionary]
var nex_rewards: Array[Dictionary]

func _ready() -> void:
	insert_items_resouces()


func insert_items_resouces() -> void:
	get_items_resources("res://Weapon/Resources")
	

func get_items_resources(folder_path: String) -> void:
	var dir: DirAccess = DirAccess.open(folder_path)
	
	if dir:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tres"):
				
				var file_path: String = folder_path + "/" + file_name
				var res: Resource = load(file_path)
				if res:
					
					var new_dicionary: Dictionary = {res.id : res} 
					items_resources_avaible.append(new_dicionary)
					
			file_name = dir.get_next()
		dir.list_dir_end()


func reset_items_resources() -> void:
	items_resources_avaible.clear()
	insert_items_resouces()
	
