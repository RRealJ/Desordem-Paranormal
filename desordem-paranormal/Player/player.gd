extends CharacterBody2D


@export var health: int = 50
@export var speed: float = 100


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
