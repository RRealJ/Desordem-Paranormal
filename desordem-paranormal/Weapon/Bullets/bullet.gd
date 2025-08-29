extends Node2D
class_name Bullet

@export var SPEED: int = 100
@export var DAMAGE: int = 5
@export var DAMAGE_TYPE: int
@onready var FORCA_OPRESSORA: bool = false

@onready var attack_collision: Area2D = $attack_collision


func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	clear_bullet()
	
	
func _on_attack_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.recieve_damage(DAMAGE, DAMAGE_TYPE)
		
		if FORCA_OPRESSORA:
			var prev_velocity: Vector2 = area.velocity
			area.velocity = -1.5 * prev_velocity
			await get_tree().create_timer(0.2).timeout
			if area:
				area.velocity = prev_velocity


func clear_bullet() -> void:
	queue_free()
