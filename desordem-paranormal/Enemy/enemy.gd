extends CharacterBody2D
class_name Enemy

@export var enemy_name: String = "Zumbi de Sangue"
@export var health: int = 30
@export var speed: float = 50
@export var damage: int = 10
@export var exp: int = 5
@export var nex: float = 0.1
@export var money: int = 5
@export var enemy_type: damage_types = damage_types.BLOOD

@onready var soft_collision: Area2D = $soft_collision
@onready var exp_scene: PackedScene = preload("res://Drops/Exp/drop_exp.tscn")
@onready var money_scene: PackedScene = preload("res://Drops/Money/drop_money.tscn")

enum damage_types {
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE,
	PHYSICAL
}

var TARGET: CharacterBody2D

func _process(delta: float) -> void:
	move(TARGET, delta)
	if (TARGET.position.x - position.x) < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false	

func move(target, delta):
	var direction = (target.position - position).normalized()
	var desired_velocity = direction * speed
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * delta * 150
	move_and_slide()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body == TARGET:
		body.recieve_damage(damage, enemy_type)	
	
func recieve_damage(player_damage, damage_type) -> void:
	player_damage = matchDamage(player_damage, damage_type)
	health -= int(player_damage)
	if health <= 0:
		if enemy_type != damage_types.PHYSICAL:
			drop_money()
		drop_exp()
		queue_free()

func drop_exp():
	var new_exp = exp_scene.instantiate()
	new_exp.exp_value = exp
	new_exp.nex_value = nex
	new_exp.global_position = global_position
	$"..".add_child(new_exp)
		
		
func drop_money():
	var new_money = money_scene.instantiate()
	var new_color: Color
	new_money.money_value = money
	
	match enemy_type:
		damage_types.BLOOD: #USING SAME ENUM
			new_color = Color(0.66, 0.08, 0.0, 1)
		damage_types.DEATH:
			new_color = Color(0.59, 0.6, 0.59, 1)
		damage_types.ENERGY:
			new_color = Color(0.67, 0.29, 1, 1)
		damage_types.KNOWLEDGE:
			new_color = Color(0.93, 0.71, 0.0, 1)
	
	new_money.change_color_to = new_color
	new_money.global_position = global_position
	$"..".add_child(new_money)

	
func matchDamage(player_damage, damage_element):
	match damage_element:
		damage_types.BLOOD:#USING SAME ENUM
			print("Bullet Damage Element: BLOOD")
			if enemy_type == damage_types.DEATH:
				player_damage /= 2
			elif enemy_type == damage_types.KNOWLEDGE:
				player_damage *= 2
			
		damage_types.DEATH:#USING SAME ENUM
			print("Bullet Damage Element: DEATH")
			if enemy_type == damage_types.ENERGY:
				player_damage /= 2
			elif enemy_type == damage_types.BLOOD:
				player_damage *= 2
				
		damage_types.ENERGY:#USING SAME ENUM
			print("Bullet Damage Element: ENERGY")
			if enemy_type == damage_types.KNOWLEDGE:
				player_damage /= 2
			elif enemy_type == damage_types.DEATH:
				player_damage *= 2
		
		damage_types.KNOWLEDGE:#USING SAME ENUM
			print("Bullet Damage Element: KNOWLEDGE")
			if enemy_type == damage_types.BLOOD:
				player_damage /= 2
			elif enemy_type == damage_types.ENERGY:
				player_damage *= 2
			
		damage_types.PHYSICAL:
			print("Bullet Damage Element: PHYSICAL")
			
		_:
			print("Bullet Damage Element: FEAR")
			player_damage *= 10
	
	return player_damage
