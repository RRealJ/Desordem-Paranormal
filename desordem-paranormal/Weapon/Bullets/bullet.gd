extends Node2D
class_name Bullet

@export var SPEED: int = 100


func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func clear_bullet():
	queue_free()
