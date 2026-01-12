extends Bullet

@export var swing_arc_degrees: float = 90.0
@export var swing_duration: float = 0.2


func _process(_delta: float) -> void:
	if $Sprite2D.frame == 2:
		$attack_collision/PointLight2D.visible = true
		$attack_collision/CollisionShape2D.disabled = false
		slash(get_global_mouse_position())

	
func slash(mouse_position: Vector2) -> void:
	# Step 1: Point toward the mouse
	var base_angle: float = (mouse_position - global_position).angle()
	$attack_collision.rotation = base_angle - deg_to_rad(swing_arc_degrees / 2.0)


func _on_attack_collision_area_entered(area: Area2D) -> void:
	super(area)
