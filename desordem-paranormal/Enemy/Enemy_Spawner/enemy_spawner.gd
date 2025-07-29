extends Node2D

@export var enemy: PackedScene
@export var quantity: int
@export var end_timer: float
@export var delay: float
@export var is_formation: bool

var time_since_last_spawn: float = 999.0
var player: CharacterBody2D
var stage: Node2D

func _ready() -> void:
	stage = $".."
	player = stage.player_character
	$Timer.start(end_timer)


func _process(delta: float) -> void:
	time_since_last_spawn += delta
	if time_since_last_spawn >= delay:
		spawn_enemy()
	

func spawn_enemy():
	time_since_last_spawn = 0.0
	for i in range(quantity):
		var new_enemy = enemy.instantiate()
		
		if is_formation:		
			new_enemy.global_position = player.global_position
		else:
			new_enemy.global_position = get_possible_enemy_position()
			
		new_enemy.TARGET = player
		stage.add_child(new_enemy)
		
		
func _on_timer_timeout() -> void:
	queue_free()


func get_possible_enemy_position():
	var screen_rect = get_viewport().get_visible_rect()
	var margin = 100
	var spawn_position = Vector2.ZERO
	
	var edge = randi() % 4
	
	match edge:
		0:  # Top
			spawn_position.x = randf_range(screen_rect.position.x, screen_rect.end.x)
			spawn_position.y = screen_rect.position.y - margin
		1:  # Bottom
			spawn_position.x = randf_range(screen_rect.position.x, screen_rect.end.x)
			spawn_position.y = screen_rect.end.y + margin
		2:  # Left
			spawn_position.x = screen_rect.position.x - margin
			spawn_position.y = randf_range(screen_rect.position.y, screen_rect.end.y)
		3:  # Right
			spawn_position.x = screen_rect.end.x + margin
			spawn_position.y = randf_range(screen_rect.position.y, screen_rect.end.y)
	
	return spawn_position
