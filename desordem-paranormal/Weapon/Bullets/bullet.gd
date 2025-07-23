extends Node2D


@export var SPEED: int = 100


func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
