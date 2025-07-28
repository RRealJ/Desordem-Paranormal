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
	var dmg_boost: int = 0
	time_last_shoot = 0.0
	upper.play("Attack")
	
	var instance = bullet_scene.instantiate()
	instance.rotation = rotation
	instance.SPEED = weapon_stats.speed
	
	if weapon_stats.weapon_type == weapon_stats.weapon_types.MAIN and character.character_data.type_of_character == character.character_data.types_of_characters.GUERREIRO: 
		dmg_boost = character.level
		
	elif weapon_stats.weapon_type == weapon_stats.weapon_types.PICKABLE and character.character_data.type_of_character == character.character_data.types_of_characters.ESPECIALISTA: 
		dmg_boost = character.level
	
	instance.DAMAGE = weapon_stats.damage + dmg_boost
	var it_crits = (randi() % 100 <= character.crit_rate)

	print(it_crits)
	
	if it_crits:
		instance.DAMAGE = instance.DAMAGE * character.crit_modify
		
	print(instance.DAMAGE)
	
	if weapon_stats.range_type == 0:
		var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
		var offset_distance: float = 10.0  # Adjust to how far from player you want
		instance.global_position = position + direction * offset_distance
		character.add_child(instance)
			
	else:
		instance.global_position = global_position
		get_tree().root.add_child(instance)
