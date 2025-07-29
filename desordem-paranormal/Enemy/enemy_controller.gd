extends Node2D

@export var enemy_spawners_data: Array[Enemy_spawner_data]
@onready var enemy_spawner: PackedScene = preload("res://Enemy/enemy_spawner.tscn")


func create_spawner(spawner_data:Enemy_spawner_data):
	var spawner = enemy_spawner.instantiate()
	spawner.enemy = spawner_data.enemy_scene
	spawner.quantity = spawner_data.enemy_quantity
	spawner.end_timer = spawner_data.enemy_timer_end
	spawner.delay = spawner_data.enemy_delay
	
	$"..".add_child(spawner)
