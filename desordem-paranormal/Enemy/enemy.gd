extends CharacterBody2D
class_name Enemy

@export var enemy_data: Enemy_data

var HEALTH: int
var SPEED: float
var DAMAGE: int
var ENEMY_TYPE: int

var TARGET: CharacterBody2D

func _ready() -> void:
	HEALTH = enemy_data.health
	SPEED = enemy_data.speed
	DAMAGE = enemy_data.damage
	ENEMY_TYPE = enemy_data.enemy_type

func _process(delta: float) -> void:
	move(TARGET, delta)

func move(target, delta):
	var direction = (target.position - position).normalized()
	var desired_velocity = direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	look_at(TARGET.global_position)
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body == TARGET:
		body.recieve_damage(DAMAGE, ENEMY_TYPE)	
	
func recieve_damage(damage, damage_type) -> void:
	damage = matchDamage(damage, damage_type)
	print("vida antes:",HEALTH)
	HEALTH -= int(damage)
	print("vida depois:",HEALTH)
	print("====================")
	if HEALTH <= 0:
		queue_free()
		
func matchDamage(damage, damage_element):
	print("========enemy========")
	match damage_element:
		enemy_data.damage_types.BLOOD:#USING SAME ENUM
			print("Bullet Damage Element: BLOOD")
			if ENEMY_TYPE == enemy_data.damage_types.DEATH:
				damage /= 2
			elif ENEMY_TYPE == enemy_data.damage_types.KNOWLEDGE:
				damage *= 2
			
		enemy_data.damage_types.DEATH:#USING SAME ENUM
			print("Enemy Damage Element: DEATH")
			if ENEMY_TYPE == enemy_data.damage_types.ENERGY:
				damage /= 2
			elif ENEMY_TYPE == enemy_data.damage_types.BLOOD:
				damage *= 2
				
		enemy_data.damage_types.ENERGY:#USING SAME ENUM
			print("Enemy Damage Element: ENERGY")
			if ENEMY_TYPE == enemy_data.damage_types.KNOWLEDGE:
				damage /= 2
			elif ENEMY_TYPE == enemy_data.damage_types.DEATH:
				damage *= 2
		
		enemy_data.damage_types.KNOWLEDGE:#USING SAME ENUM
			print("Enemy Damage Element: KNOWLEDGE")
			if ENEMY_TYPE == enemy_data.damage_types.BLOOD:
				damage /= 2
			elif ENEMY_TYPE == enemy_data.damage_types.ENERGY:
				damage *= 2
			
		enemy_data.damage_types.PHYSICAL:
			print("Enemy Damage Element: PHYSICAL")
			print("Dont Change Damage now")
			
		_:
			print("Enemy Damage Element: FEAR")
			damage *= 10
	
	return damage
