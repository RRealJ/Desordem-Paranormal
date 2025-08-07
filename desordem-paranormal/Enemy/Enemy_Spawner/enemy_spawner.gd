extends Node2D

@export var enemy_scene: PackedScene
@export var quantity: int
@export var end_timer: float
@export var spawn_interval: float
@export var wait_for_empty_space: bool= false
@export var empty_radius: float= 20.0
@export var is_formation: bool
@export var velocity_mod: float
@onready var timer: Timer = $Timer
@onready var LifeTimer: Timer = $LifeTime


var paused:= false
var busy:= false
var empty_space_query: PhysicsShapeQueryParameters2D


func _ready() -> void:
	if wait_for_empty_space:
		var query := PhysicsShapeQueryParameters2D.new()
		query.collide_with_areas = true
		query.collide_with_bodies = true
		query.collision_mask = Global.ENEMY_COLLISION_LAYER
		query.transform = transform
		var shape := CircleShape2D.new()
		shape.radius = empty_radius
		query.shape = shape
		empty_space_query = query

	timer.wait_time = spawn_interval
	timer.start()
	LifeTimer.wait_time = end_timer
	LifeTimer.start()

func spawn_enemy() -> void:
	if busy: return
	if paused: return
	
	for i in range(quantity):
		if wait_for_empty_space:		
			busy= true
			await get_tree().physics_frame
			busy= false
			var space_state: PhysicsDirectSpaceState2D= get_world_2d().direct_space_state
			if not space_state: return
			var result := space_state.intersect_shape(empty_space_query)
			if result : return
			
		var inst_enemy := enemy_scene.instantiate()
		inst_enemy.global_position = get_possible_enemy_position()
		
		inst_enemy.speed = inst_enemy.speed * velocity_mod
		Global.enemies.add_child(inst_enemy)


func _on_timer_timeout() -> void:
	spawn_enemy()
	
	
func get_possible_enemy_position() -> Vector2:
	var player: CharacterBody2D = Global.player
	var camera: Camera2D = player.get_node("Camera2D")
	var margin: float = 100
	var spawn_position: Vector2 = Vector2.ZERO
	
	# Get the screen size
	var screen_size: Vector2 = get_viewport().get_visible_rect().size
	var half_screen: Vector2 = screen_size * 0.5
	
	# Get world-space screen rectangle centered on the camera
	var cam_pos: Vector2 = camera.global_position
	var screen_left: int = cam_pos.x - half_screen.x
	var screen_right: int  = cam_pos.x + half_screen.x
	var screen_top: int  = cam_pos.y - half_screen.y
	var screen_bottom: int  = cam_pos.y + half_screen.y
	
	var edge: int = randi() % 4
	
	match edge:
		0:  # Top
			spawn_position.x = randf_range(screen_left, screen_right)
			spawn_position.y = screen_top - margin
		1:  # Bottom
			spawn_position.x = randf_range(screen_left, screen_right)
			spawn_position.y = screen_bottom + margin
		2:  # Left
			spawn_position.x = screen_left - margin
			spawn_position.y = randf_range(screen_top, screen_bottom)
		3:  # Right
			spawn_position.x = screen_right + margin
			spawn_position.y = randf_range(screen_top, screen_bottom)
			
	return spawn_position


func _on_life_time_timeout() -> void:
	queue_free()
