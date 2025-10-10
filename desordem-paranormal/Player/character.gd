class_name Player
extends CharacterBody2D

signal healthChange

@export var character_data: Character_data

@onready var upper: Sprite2D = $Upper
@onready var bottom: Sprite2D = $Bottom
@onready var main_weapon: Node2D = $main_weapon
@onready var nex_upgrades: Node2D = $Nex_Upgrades
@onready var equips: Node2D = $Equips
@onready var pickable_weapons: Node2D = $Weapons

var max_health: int
var health: int
var speed: float
var level: int
var crit_rate: float
var crit_modify: float
var exp: int = 0
var nex: float = 0.0
var money: int = 0

var iframes: float = 1.0

var invencibilidade: bool = false
var inquebravel_invenci: bool = false
var prevent_death: bool = false

var resistence: float = 0
var cai_dentro: bool = false
var revidar: bool = false
var duro_de_matar: bool = false
var surto_de_adrenalina: bool = false
var inquebravel: bool = true


func _init() -> void:
	Global.player = self


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


func _physics_process(delta: float) -> void:
	if main_weapon.rotation_degrees > 90 and main_weapon.rotation_degrees < 270:
		bottom.flip_h = true
		upper.flip_h = true
		
	else:
		bottom.flip_h = false
		upper.flip_h = false
		
	var direction:Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()
	
	
func recieve_damage(damage: float, damage_type: int, enemy: Enemy) -> void:
	damage = matchDamage(damage, damage_type)
	
	if !invencibilidade and !inquebravel_invenci:
		
		print("Dano")
			
		if health >= 0:
			health -= int(damage)
		
		emit_signal("healthChange")
		
		$invicibility.start(iframes)
		invencibilidade = true
		
		if revidar:
			enemy.recieve_damage(damage*2, character_data.elements_of_characters.PHYSICAL)
		
		if !prevent_death:
			
			if health <= 0:
					
				if duro_de_matar:
					prevent_death = true
					print("efeito duro de matar ativo")
					await get_tree().create_timer(15.0).timeout
					print("efeito duro de matar desativado")
					$"Nex_Upgrades/duro_de_matar/recarga".start(120)
					duro_de_matar = false
					prevent_death = false		
					
					
				elif inquebravel and !duro_de_matar:
					prevent_death = true
					inquebravel_invenci = true		
					print("inquebravel ativado")
					health = int(max_health/2)
					emit_signal("healthChange")
					await get_tree().create_timer(5).timeout
					print("inquebravel desativado")
					$"Nex_Upgrades/inquebravel/recarga".start(60)
					inquebravel = false
					inquebravel_invenci = false
					prevent_death = false

func matchDamage(damage:float, damage_element: int) -> float:
	match damage_element:
		
		character_data.elements_of_characters.BLOOD:#USING SAME ENUM AS TYPE_OF_DAMAGE
			if character_data.element_of_character == character_data.elements_of_characters.DEATH:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.KNOWLEDGE:
				damage *= 2
			
		character_data.elements_of_characters.DEATH:
			if character_data.element_of_character == character_data.elements_of_characters.ENERGY:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.BLOOD:
				damage *= 2
				
		character_data.elements_of_characters.ENERGY:
			if character_data.element_of_character == character_data.elements_of_characters.KNOWLEDGE:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.DEATH:
				damage *= 2
		
		character_data.elements_of_characters.KNOWLEDGE:
			if character_data.element_of_character == character_data.elements_of_characters.BLOOD:
				damage /= 2
			elif character_data.element_of_character == character_data.elements_of_characters.ENERGY:
				damage *= 2
			
		character_data.elements_of_characters.PHYSICAL:
			pass
			
		_:
			damage *= 5
			
	return damage


func insert_nex_upgrade(nex_upgrade: Nex_stats) -> void:
	var new_nex_upgrade := nex_upgrade.nex_scene.instantiate()
	nex_upgrade.add_child(new_nex_upgrade)


func get_nex_upgrades(element: Node2D) -> void:
	var nexes: Array[Node] = nex_upgrades.get_children()
	for n in nexes:
		n.apply_upgrade(element)
	

func get_equip_upgrades(element: Node2D) -> void:
	var equipes: Array[Node] = equips.get_children()
	for e in equipes:
		e.apply_upgrade(element)


func update_weapon_equip_ritual_nex() -> void:
	get_nex_upgrades(main_weapon)
	
	var weapons: Array[Node] = pickable_weapons.get_children()
	for w in weapons:
		get_nex_upgrades(w)


func _on_invicibility_timeout() -> void:
	invencibilidade = false
