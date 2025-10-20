class_name Spawner

extends Node2D

@export var enemy_spawners_data: Array[Enemy_spawner_data]
@onready var enemy_spawner: PackedScene = preload("res://Enemy/Enemy_Spawner/enemy_spawner.tscn")


## Creates a Spawner of Enemies
## @param spawner_data: The data of the Spawner.
## @param velocity_mod: Multiply the Speed of Enemy.
## @param health_mod: Multiply the Health of Enemy.
## @param damage_mod: Multiply the Damage of Enemy.
## @param exp_mod: Multiply the amount of experience when Enemy dies.
## @param nex_mod: Multiply the amount of NEX when Enemy dies.
## @param money_mod: Multiply the amount of money when Enemy dies.
func create_spawner(spawner_data:Enemy_spawner_data, 
velocity_mod: float = 1.0, health_mod: float = 1.0,
damage_mod: float = 1.0, exp_mod: float = 1.0,
nex_mod: float = 1.0, money_mod: float = 1.0) -> void:
	
	print("Creating Spawner")
	
	var spawner := enemy_spawner.instantiate()
	spawner.enemy_scene = spawner_data.enemy_scene
	spawner.quantity = spawner_data.enemy_quantity
	spawner.end_timer = spawner_data.enemy_timer_end
	spawner.spawn_interval = spawner_data.enemy_delay
	spawner.is_formation = spawner_data.enemy_is_formation
	spawner.velocity_mod = velocity_mod
	spawner.health_mod = health_mod
	spawner.damage_mod = damage_mod
	spawner.exp_mod = exp_mod
	spawner.nex_mod = nex_mod
	spawner.money_mod = money_mod
	
	$"..".add_child(spawner)
	
	print("Spawner Created")
