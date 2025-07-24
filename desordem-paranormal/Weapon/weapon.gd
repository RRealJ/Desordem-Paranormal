extends Node2D

@export var weapon_stats: Weapon_stats
@export var bullet_scene: PackedScene
@onready var upper: AnimatedSprite2D = $"../Upper"

var time_last_shoot: float = 0.0
var character: CharacterBody2D

func _ready() -> void:
	character = $".."

func _process(delta: float) -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.x = -1
	else:
		scale.x = 1
		
	time_last_shoot += delta
	look_at(get_global_mouse_position())

	if time_last_shoot >= weapon_stats.attack_cooldown:
		shoot()

func shoot():
	time_last_shoot = 0.0
	upper.play("Attack")

	var instance = bullet_scene.instantiate()
	instance.rotation = rotation
	
	if weapon_stats.range_type == 0:
		var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
		var offset_distance: float = 10.0  # Adjust to how far from player you want
		instance.global_position = position + direction * offset_distance
		character.add_child(instance)
			
	else:
		instance.global_position = global_position
		get_tree().root.add_child(instance)
