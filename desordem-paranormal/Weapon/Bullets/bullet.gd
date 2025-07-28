extends Node2D
class_name Bullet

@export var SPEED: int = 100
@export var DAMAGE: int = 5
@export var DAMAGE_TYPE: int

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_katana_slash_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.recieve_damage(DAMAGE, DAMAGE_TYPE)


func clear_bullet():
	queue_free()
