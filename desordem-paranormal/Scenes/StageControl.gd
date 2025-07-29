extends Node2D


@onready var player_character: CharacterBody2D = get_tree().get_nodes_in_group("Player")[0]
@onready var enemy_controller: Node2D = $enemy_controller


func _ready() -> void:
	enemy_controller.create_spawner(enemy_controller.enemy_spawners_data[0])
