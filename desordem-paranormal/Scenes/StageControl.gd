extends Node2D


@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("Player")[0]
@onready var enemy_controller: Node2D = $enemy_controller
@onready var enemies: Node2D = $Enemies

@export var pause_below_n_fps: int= 20

func _ready() -> void:
	Global.enemies = enemies
	Global.obstacle_tile_map = $"TileMapLayer Obstacles"
	update_pathfinder(false)
	enemy_controller.create_spawner(enemy_controller.enemy_spawners_data[0])


func update_pathfinder(non_blocking: bool= true) -> void:
	if Global.pathfinder:
		Global.pathfinder.update(player.position, non_blocking)
