extends Node2D

@export var enemy_spawner_data: Array[Enemy_spawner_data]
@onready var enemy_spawner: PackedScene = preload("res://Enemy/enemy_spawner.tscn")

func create_spawner(spawner_data:Enemy_spawner_data):
	var spawner = enemy_spawner.instantiate()
	spawner.enemy = spawner_data.enemy
	spawner.quantity = spawner_data.quantity
	spawner.end_timer = spawner_data.end_timer
	spawner.delay = spawner_data.delay
	
	$"..".add_child(spawner)
	
