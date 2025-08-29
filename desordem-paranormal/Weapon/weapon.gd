class_name Weapon
extends Node2D

@export var weapon_stats: Weapon_stats
@onready var anim: AnimationPlayer = $"../animAttack"

var time_last_shoot: float = 0.0
var character: Player

var mouse_sens: int = 300

var dmg_boost: float = 0.0
var crit_rate: float 
var crit_modifier: float

var a_favorita: bool = false
var tecnica_letal: bool = false
var tecnica_secreta: bool = false
var extra_attack1: bool = false
var forca_opressora: bool = false
var potencia_maxima: bool = false
var sempre_alerta: bool = false

func _ready() -> void:
	character = Global.player
	crit_rate = character.crit_rate
	crit_modifier = character.crit_modify
	#character.get_nex_upgrades(self)
	#character.get_equip_upgrades(self)


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
	time_last_shoot = 0.0
	var dmg_boost_attack: float = dmg_boost
	anim.play("Attack")
	
	var instance := weapon_stats.bullet_scene.instantiate()
	instance.rotation = rotation
	instance.SPEED = weapon_stats.speed
	
	if weapon_stats.weapon_type == weapon_stats.weapon_types.MAIN and character.character_data.type_of_character == character.character_data.types_of_characters.GUERREIRO: 
		dmg_boost_attack += character.level
		
	elif weapon_stats.weapon_type == weapon_stats.weapon_types.PICKABLE and character.character_data.type_of_character == character.character_data.types_of_characters.ESPECIALISTA: 
		dmg_boost_attack += character.level
	
	dmg_boost_attack += (weapon_stats.level * 5) 
	instance.DAMAGE = weapon_stats.damage + dmg_boost_attack
	
	var it_crits: bool = (randi() % 100 <= crit_rate)
	
	if it_crits:
		instance.DAMAGE *= crit_modifier
	
	instance.DAMAGE_TYPE = weapon_stats.element_type
	
	instance.DAMAGE = int(instance.DAMAGE)
	
	if potencia_maxima:
		instance.DAMAGE *= 3
		
	instance.FORCA_OPRESSORA = forca_opressora
	
	if weapon_stats.range_type == weapon_stats.range_types.MELEE:
		var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
		var offset_distance: float = 10.0  # Adjust to how far from player you want
		instance.global_position = position + direction * offset_distance
		
		if scale.x > 0:
			instance.scale.y = scale.x + 0.5
		else:
			instance.scale.y = scale.x - 0.5
		
		print(instance)
		character.add_child(instance)	
		
		check_attack_extra(character)

			
	else:
		instance.global_position = global_position
		print(instance)
		Global.stage.add_child(instance)
		
		check_attack_extra(Global.stage)
		

func check_attack_extra(place: Node2D) -> void:
	var instance: Bullet	
	
	if extra_attack1:
		await get_tree().create_timer(0.3).timeout	
		instance = attack_extra()
		print(instance)
		place.add_child(instance)
				
	if forca_opressora and ((randi() % 100) <= Global.player.character_data.luck):
		await get_tree().create_timer(0.3).timeout	
		instance = attack_extra()
		place.add_child(instance)
		
	if character.surto_de_adrenalina and ((randi() % 4) == 1):
		await get_tree().create_timer(0.3).timeout	
		instance = attack_extra()
		place.add_child(instance)
	
	if sempre_alerta:
		await get_tree().create_timer(0.3).timeout	
		instance = attack_extra()
		place.add_child(instance)


func attack_extra() -> Bullet:
	time_last_shoot = 0.0
	anim.play("Attack")
	var dmg_boost_attack: float = dmg_boost
	
	var instance := weapon_stats.bullet_scene.instantiate()
	instance.rotation = rotation
	instance.SPEED = weapon_stats.speed
	
	if weapon_stats.weapon_type == weapon_stats.weapon_types.MAIN and character.character_data.type_of_character == character.character_data.types_of_characters.GUERREIRO: 
		dmg_boost_attack += character.level
		
	elif weapon_stats.weapon_type == weapon_stats.weapon_types.PICKABLE and character.character_data.type_of_character == character.character_data.types_of_characters.ESPECIALISTA: 
		dmg_boost_attack += character.level
	
	dmg_boost_attack += (weapon_stats.level * 5) 
	instance.DAMAGE = weapon_stats.damage + dmg_boost_attack
	
	var it_crits: bool = (randi() % 100 <= crit_rate)
	
	if it_crits:
		instance.DAMAGE *= crit_modifier
	
	instance.DAMAGE_TYPE = weapon_stats.element_type
	
	instance.DAMAGE = int(instance.DAMAGE)
	instance.FORCA_OPRESSORA = forca_opressora
	
	if weapon_stats.range_type == weapon_stats.range_types.MELEE:
		var direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
		var offset_distance: float = 10.0  # Adjust to how far from player you want
		instance.global_position = position + direction * offset_distance
		
		if scale.x > 0:
			instance.scale.y = scale.x + 0.5
		else:
			instance.scale.y = scale.x - 0.5
			
	return instance
