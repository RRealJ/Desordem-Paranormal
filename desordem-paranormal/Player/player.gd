extends CharacterBody2D


@export var health: int = 50
@export var speed: float = 100
@export var weapon_stats: Weapon_stats
@export var bullet: PackedScene

var main_weapon: Node2D
var shooting: bool = false
var weapon_cooldown: Timer

func _ready() -> void:
	main_weapon = $main_weapon
	weapon_cooldown = $weapon_cooldown
	weapon_cooldown.wait_time = weapon_stats.attack_cooldown
	$Bottom.play("Walking")


func _process(delta: float) -> void:
		
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
	
	
func shoot():
	$Upper.play("Attack")
	shooting = true
	
	var instance = bullet.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = global_position
	instance.rotation = rotation
	

func _on_weapon_cooldown_timeout() -> void:
	shooting = false
	shoot()
