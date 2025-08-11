extends Node2D

@export var weapon_stats: Weapon_stats
@onready var anim: AnimationPlayer = $"../animAttack"

var time_last_shoot: float = 0.0
var character: CharacterBody2D

var mouse_sens: int = 300

func _ready() -> void:
	character = Global.player


func _physics_process(delta: float) -> void:
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.x = -1
	else:
		scale.x = 1
		
	time_last_shoot += delta

	#get Vector2 of Right Joystick
	var direction: Vector2
	direction.x = Input.get_action_strength("cursor_right") - Input.get_action_strength("cursor_left")
	direction.y = Input.get_action_strength("cursor_down") - Input.get_action_strength("cursor_up")
	
	var movement: Vector2 = mouse_sens * direction * delta
	if movement:
		get_viewport().warp_mouse(round( get_viewport().get_mouse_position() + movement))
		#IT NEEDS THE ROUND(), otherwise it goes into the fucking stratosphere
	
	look_at(get_global_mouse_position())

	if time_last_shoot >= weapon_stats.attack_cooldown - (0.1 * StoreUpgrades.recharge_upgrade):
		shoot()

func shoot() -> void:
	var dmg_boost: int = 0
	time_last_shoot = 0.0
	anim.play("Attack")
	
	var instance := weapon_stats.bullet_scene.instantiate()
	instance.rotation = rotation
	instance.SPEED = weapon_stats.speed
	
	if weapon_stats.weapon_type == weapon_stats.weapon_types.MAIN and character.character_data.type_of_character == character.character_data.types_of_characters.GUERREIRO: 
		dmg_boost = character.level
		
	elif weapon_stats.weapon_type == weapon_stats.weapon_types.PICKABLE and character.character_data.type_of_character == character.character_data.types_of_characters.ESPECIALISTA: 
		dmg_boost = character.level
	
	dmg_boost += (weapon_stats.level * 5) 
	instance.DAMAGE = weapon_stats.damage + dmg_boost
	var it_crits: bool = (randi() % 100 <= character.crit_rate)
	
	if it_crits:
		instance.DAMAGE = instance.DAMAGE * character.crit_modify
	
	instance.DAMAGE_TYPE = weapon_stats.element_type
	
	if weapon_stats.range_type == weapon_stats.range_types.MELEE:
		var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
		var offset_distance: float = 10.0  # Adjust to how far from player you want
		instance.global_position = position + direction * offset_distance
		
		if scale.x > 0:
			instance.scale.y = scale.x + 0.5
		else:
			instance.scale.y = scale.x - 0.5
			
		character.add_child(instance)
			
	else:
		instance.global_position = global_position
		get_tree().root.add_child(instance)
