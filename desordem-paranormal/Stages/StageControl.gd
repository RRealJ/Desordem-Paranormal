extends Node2D


@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("Player")[0]
@onready var enemy_controller: Node2D = $enemy_controller
@onready var enemies: Node2D = $Enemies

@export var pause_below_n_fps: int= 20

func _ready() -> void:
	Global.enemies = enemies
	#enemy_controller.create_spawner(enemy_controller.enemy_spawners_data[0]) #velocity_mod


		
