extends Bullet

@onready var tween: Tween = get_tree().create_tween()

@export var swing_arc_degrees: float = 90.0
@export var swing_duration: float = 0.2


func _process(delta: float) -> void:
	if $Sprite2D.frame == 2:
		$katana_slash/PointLight2D.visible = true
		$katana_slash/CollisionShape2D.disabled = false
		slash(get_global_mouse_position())

	
func slash(mouse_position: Vector2) -> void:
	# Step 1: Point toward the mouse
	var base_angle: float = (mouse_position - global_position).angle()
	$katana_slash.rotation = base_angle - deg_to_rad(swing_arc_degrees / 2.0)

	# Step 2: Animate the swing
	tween = get_tree().create_tween()
	tween.tween_property($katana_slash, "rotation", base_angle + deg_to_rad(swing_arc_degrees / 2.0), swing_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
