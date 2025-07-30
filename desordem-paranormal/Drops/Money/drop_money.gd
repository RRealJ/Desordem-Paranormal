extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var change_color_to: Color
@export var money_value: int = 0


func _ready() -> void:
	sprite.set_modulate(change_color_to)
