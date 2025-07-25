extends CharacterBody2D

const TYPE = 0 #Guerreiro

@export var health: int = 50
@export var speed: float = 100
@export var level: int = 0
@export var crit_rate: float = 10 
@export var crit_modify: float = 2.5

@onready var upper: AnimatedSprite2D = $Upper
@onready var bottom: AnimatedSprite2D = $Bottom
@onready var main_weapon: Node2D = $main_weapon
@onready var cursor_pointer : String = "res://Assets/Sprites/Pointers/pointer_blood.png"

func _ready() -> void:
	bottom.play("Walking")
	$Pointer.change_pointer(cursor_pointer)
	

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
	
