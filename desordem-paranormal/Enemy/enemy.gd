extends CharacterBody2D
class_name Enemy

var SPEED: float = 50
var TARGET: CharacterBody2D
var DAMAGE: int = 10
var ENEMY_TYPE: damage_types = damage_types.BLOOD
var HEALTH: int = 30

enum damage_types {
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE,
	PHYSICAL
}

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
		damage_types.BLOOD:#USING SAME ENUM
			print("Bullet Damage Element: BLOOD")
			if ENEMY_TYPE == damage_types.DEATH:
				damage /= 2
			elif ENEMY_TYPE == damage_types.KNOWLEDGE:
				damage *= 2
			
		damage_types.DEATH:#USING SAME ENUM
			print("Enemy Damage Element: DEATH")
			if ENEMY_TYPE == damage_types.ENERGY:
				damage /= 2
			elif ENEMY_TYPE == damage_types.BLOOD:
				damage *= 2
				
		damage_types.ENERGY:#USING SAME ENUM
			print("Enemy Damage Element: ENERGY")
			if ENEMY_TYPE == damage_types.KNOWLEDGE:
				damage /= 2
			elif ENEMY_TYPE == damage_types.DEATH:
				damage *= 2
		
		damage_types.KNOWLEDGE:#USING SAME ENUM
			print("Enemy Damage Element: KNOWLEDGE")
			if ENEMY_TYPE == damage_types.BLOOD:
				damage /= 2
			elif ENEMY_TYPE == damage_types.ENERGY:
				damage *= 2
			
		damage_types.PHYSICAL:
			print("Enemy Damage Element: PHYSICAL")
			print("Dont Change Damage now")
			
		_:
			print("Enemy Damage Element: FEAR")
			damage *= 10
	
	return damage
