extends Node2D
class_name Bullet

@export var SPEED: int = 100
@export var DAMAGE: int = 5
@export var DAMAGE_TYPE: int

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_katana_slash_hit_enemy_hurtbox(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		area.recieve_damage(DAMAGE, DAMAGE_TYPE)



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	clear_bullet()
	

func clear_bullet() -> void:
	queue_free()
