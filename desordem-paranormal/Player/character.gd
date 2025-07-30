extends CharacterBody2D

@export var character_data: Character_data

@onready var upper: Sprite2D = $Upper
@onready var bottom: Sprite2D = $Bottom
@onready var main_weapon: Node2D = $main_weapon

var max_health: int
var health: int
var speed: float
var level: int
var crit_rate: float
var crit_modify: float
var exp: int = 0
var nex: float = 0.0
var money: int = 0

func _ready() -> void:
	$Pointer.change_pointer(character_data.element_of_character)
	max_health = character_data.health
	health = max_health
	speed = character_data.speed
	level = character_data.level
	crit_rate = character_data.crit_rate
	crit_modify = character_data.crit_modify
	$Pointer.visible = true
	$animWalk.play("Walking")

func _process(delta: float) -> void:
	if main_weapon.rotation_degrees > 90 and main_weapon.rotation_degrees < 270:
		bottom.flip_h = true
		upper.flip_h = true
		upper.position.x = bottom.position.x - 8
	else:
		bottom.flip_h = false
		upper.flip_h = false
		upper.position.x = bottom.position.x + 8
			
	var direction:Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("MoveUp"):
		direction.y -= 1
	if Input.is_action_pressed("MoveDown"):
		direction.y += 1
	if Input.is_action_pressed("MoveLeft"):
		direction.x -= 1
	if Input.is_action_pressed("MoveRight"):
		direction.x += 1

	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()
	
func recieve_damage(damage, damage_type) -> void:
	damage = matchDamage(damage, damage_type)
	health -= int(damage)
	updateUI()
		
func matchDamage(damage, damage_element):
	match damage_element:
		
		character_data.elements_of_characters.BLOOD:#USING SAME ENUM
			print("Enemy Damage Element: BLOOD")
			if character_data.element_of_character == character_data.elements_of_characters.DEATH:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.KNOWLEDGE:
				damage *= 2
			
		character_data.elements_of_characters.DEATH:#USING SAME ENUM
			print("Enemy Damage Element: DEATH")
			if character_data.element_of_character == character_data.elements_of_characters.ENERGY:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.BLOOD:
				damage *= 2
				
		character_data.elements_of_characters.ENERGY:#USING SAME ENUM
			print("Enemy Damage Element: ENERGY")
			if character_data.element_of_character == character_data.elements_of_characters.KNOWLEDGE:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.DEATH:
				damage *= 2
		
		character_data.elements_of_characters.KNOWLEDGE:#USING SAME ENUM
			print("Enemy Damage Element: KNOWLEDGE")
			if character_data.element_of_character == character_data.elements_of_characters.BLOOD:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.ENERGY:
				damage *= 2
			
		character_data.elements_of_characters.PHYSICAL:
			print("Enemy Damage Element: PHYSICAL")
			
		_:
			print("Enemy Damage Element: FEAR")
			damage *= 10
	
	return damage

func updateUI() -> void:
	pass
