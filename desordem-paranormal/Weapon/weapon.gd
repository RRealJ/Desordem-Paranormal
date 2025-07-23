extends Node2D

@export var weapon_stats: Weapon_stats
@export var bullet_scene: PackedScene


func _process(delta: float) -> void:
	shoot()
	

func shoot():
	var instance = bullet_scene.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = global_position
	instance.rotation = rotation
	
