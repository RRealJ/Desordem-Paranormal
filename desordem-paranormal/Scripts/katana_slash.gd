extends Bullet

@onready var tween := get_tree().create_tween()

@export var swing_arc_degrees := 90.0
@export var swing_duration := 0.2


func _process(delta: float) -> void:
	if $AnimatedSprite2D.frame == 2:
		slash(get_global_mouse_position())

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
	
	
func slash(mouse_position: Vector2):
	# Step 1: Point toward the mouse
	var base_angle = (mouse_position - global_position).angle()
	$katana_slash.rotation = base_angle - deg_to_rad(swing_arc_degrees / 2.0)

	# Step 2: Animate the swing
	tween = get_tree().create_tween()
	tween.tween_property($katana_slash, "rotation", base_angle + deg_to_rad(swing_arc_degrees / 2.0), swing_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
