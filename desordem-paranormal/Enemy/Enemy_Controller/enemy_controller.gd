extends Node2D

@export var enemy_spawners_data: Array[Enemy_spawner_data]
@onready var enemy_spawner: PackedScene = preload("res://Enemy/Enemy_Spawner/enemy_spawner.tscn")


func create_spawner(spawner_data:Enemy_spawner_data, velocity_mod: float = 1.0) -> void:
	print("Spawner Created")
	var spawner := enemy_spawner.instantiate()
	spawner.enemy_scene = spawner_data.enemy_scene
	spawner.quantity = spawner_data.enemy_quantity
	spawner.end_timer = spawner_data.enemy_timer_end
	spawner.spawn_interval = spawner_data.enemy_delay
	spawner.is_formation = spawner_data.enemy_is_formation
	spawner.velocity_mod = velocity_mod
	
	$"..".add_child(spawner)
