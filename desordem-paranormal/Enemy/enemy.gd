extends Area2D
class_name Enemy

@export var enemy_name: String = "Zumbi de Sangue"
@export var health: int = 30
@export var speed: float = 50
@export var damage: int = 10
@export var exp: int = 5
@export var nex: float = 0.01
@export var money: int = 5
@export var enemy_type: damage_types = damage_types.BLOOD

@onready var exp_scene: PackedScene = preload("res://Drops/Exp/drop_exp.tscn")
@onready var money_scene: PackedScene = preload("res://Drops/Money/drop_money.tscn")

enum damage_types {
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE,
	PHYSICAL
}

var TARGET: CharacterBody2D = Global.player

# if enabled this will dynamically trigger an intersect_shape()
# query instead of using the Separation Area node
@export var dynamic_separation_area: bool= true

# importance of target direction for final velocity
@export var target_weight: float= 10.0

# importance of separation from neighboring enemies for final velocity
@export var separation_weight: float= 150.0
@export var separation_radius: float= 20.0

# weight that forces enemies to steer away from the player the closer they get
@export var player_separation_weight: float= 1000.0

@export var maximum_speed: float= 25.0

# skip n calculation frames
@export var skip_frames: int= 20

# fine-tune the intersect_shape() max_results
@export var max_intersect_results:= 8

# for smoother movement
@export_range(0.0, 1.0) var jitter_fix= 0.5

@onready var collision_shape: CollisionShape2D = $hurtbox
@onready var separation_area: Area2D = $"Separation Area"
@onready var separation_collision_shape: CollisionShape2D = $"Separation Area/CollisionShape2D"

var velocity: Vector2
var circle_shape: CircleShape2D

# separation query for the outer area
var query: PhysicsShapeQueryParameters2D

# obstacle collision query for the inner area
var obstacle_query: PhysicsShapeQueryParameters2D

# offset the tick used for skip_frames by a random number so
# it's more evenly spread out 
var tick_offset: int

var prev_position: Vector2

# the collision normal gets sent from an obstacle if we enter it
# and helps us to resolve collision and bounce off the obstacle
var obstacle_collision_normal: Vector2



func _ready() -> void:
	if dynamic_separation_area:
		# with a "dynamic" separation area we are getting rid off the 
		# Separation Area-node and replace it with an immediate query to the 
		# physics space when we need it. especially useful when skipping
		# frames, since an Area-node would still be running overlap checks
		# each frame, but with a query it will only if we say so
		
		# store the actual shape and get rid off the rest
		circle_shape= separation_collision_shape.shape
		separation_area.queue_free()
		
		# pre-building the query. each time we run it we need to 
		# update the position ( transform.origin ) in the query to
		# our current position
		query= PhysicsShapeQueryParameters2D.new()
		query.collide_with_bodies= false
		query.collide_with_areas= true
		query.collision_mask= Global.ENEMY_COLLISION_LAYER
		query.shape= circle_shape
		query.exclude= [(get_node(".") as Area2D).get_rid()]
		query.transform= Transform2D.IDENTITY

	else:
		assert(separation_collision_shape.shape is CircleShape2D)
		(separation_collision_shape.shape as CircleShape2D).radius= separation_radius

	# pre-building the obstacle query
	obstacle_query= PhysicsShapeQueryParameters2D.new()
	obstacle_query.collide_with_bodies= false
	obstacle_query.collide_with_areas= true
	obstacle_query.collision_mask= Global.OBSTACLE_COLLISION_LAYER
	obstacle_query.shape= collision_shape.shape

	# random tick offset 
	tick_offset= randi() % 60


func _physics_process(delta: float) -> void:
	if obstacle_collision_normal:
		# move enemy back to position before collision and find a new position
		# like it bounced off the obstacle
		position= prev_position + ( position - prev_position ).bounce(obstacle_collision_normal)
		
		# bounce the velocity off the the obstacle as well, so it doesn't 
		# immediately go back it into it
		velocity= velocity.bounce(obstacle_collision_normal)
		
		# for safety, push the enemy a little bit away from the obstacle to be sure
		# it doesn't overlap any more ( really necessary? )
		position+= velocity * delta
		
		obstacle_collision_normal= Vector2.ZERO
	
	elif ( Engine.get_physics_frames() + tick_offset ) % ( skip_frames + 1 ) == 0:
		# this code block will only run each n physics ticks
		# where n is defined in skip_frames 
		
		# apply jitter fix for smoother movement
		velocity= velocity.lerp(Vector2.ZERO, 1.0 - jitter_fix)
		
		# collect all positions of nearby enemies we need to
		# separate from to avoid overlaps and calculate the
		# resulting velocity
		for other_pos in get_overlapping_area_positions():
			separate_from(other_pos, separation_weight)
		
		# also separate from the player, depending on the distance
		#separate_from(Global.player.position, player_separation_weight)

		# add the target direction ( towards the enemy ) to our velocity
		var target_dir: Vector2
		#if Global.pathfinder:
		#	target_dir= Global.pathfinder.get_direction(position)
		
		#if not target_dir:
		target_dir= (Global.player.global_position - position).normalized()
		
		velocity+= target_dir * target_weight

		# set the velocity to "maximum_speed", which currently
		# acts more like a constant speed
		velocity= velocity.normalized() * maximum_speed

	# store the current position so we can fall back to it if the new position
	# causes a collision with an obstacle
	prev_position= position
	
	# move according to our velocity
	position+= velocity * delta
	
	if (TARGET.position.x - position.x) < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false	


# find all colliders the Seperation Area overlaps with and
# return their positions
func get_overlapping_area_positions()-> Array[Vector2]:
	var result: Array[Vector2]= []
	
	if dynamic_separation_area:
		# update the position for our dynamic query, since it isn't
		# linked to our node in any way
		
		query.transform.origin= position
		
		# look for intersecting shapes, which means looking for all overlaps
		# between our Separation Shape and other enemies root Area.
		# the amount of results can be tweaked with "max_intersect_results": 
		# - with more results the separation becomes more precise, potentially
		# accounting for more nearby enemies.
		# - less results should mean more performance
		var query_result= get_world_2d().direct_space_state.intersect_shape(query, max_intersect_results)
		
		if query_result:
			for item in query_result:
				result.append(item.collider.position)
	else:
		for area in separation_area.get_overlapping_areas():
			result.append(area.position)
	
	return result


# adding velocity to move away from the given position
# with the given weight and considering the distance to our
# current position. the closer we are the greater the factor 
func separate_from(other_pos: Vector2, weight: float):
	var vec: Vector2= position - other_pos
	if vec.is_zero_approx(): return
	velocity+= vec.normalized() * 1.0 / vec.length() * weight


# called from an Area Obstacle if it detects an overlap and we get
# the resulting collision normal
func handle_obstacle_collision(normal: Vector2):
	obstacle_collision_normal= normal


func is_area()-> bool:
	return true


func _on_hitbox_body_entered(body: CharacterBody2D) -> void:
	if body == TARGET:
		body.recieve_damage(damage, enemy_type)	
	
	
func recieve_damage(player_damage, damage_type) -> void:
	player_damage = matchDamage(player_damage, damage_type)
	health -= int(player_damage)
	if health <= 0:
		if enemy_type != damage_types.PHYSICAL:
			drop_money()
		drop_exp()
		queue_free()


func drop_exp():
	var new_exp = exp_scene.instantiate()
	new_exp.exp_value = exp
	new_exp.nex_value = nex
	new_exp.global_position = global_position
	$"..".add_child(new_exp)
			
			
func drop_money():
	var new_money = money_scene.instantiate()
	var new_color: Color
	new_money.money_value = money
	
	match enemy_type:
		damage_types.BLOOD: #USING SAME ENUM
			new_color = Color(0.66, 0.08, 0.0, 1)
		damage_types.DEATH:
			new_color = Color(0.59, 0.6, 0.59, 1)
		damage_types.ENERGY:
			new_color = Color(0.67, 0.29, 1, 1)
		damage_types.KNOWLEDGE:
			new_color = Color(0.93, 0.71, 0.0, 1)
	
	new_money.change_color_to = new_color
	new_money.global_position = global_position
	$"..".add_child(new_money)


func matchDamage(player_damage, damage_element):
	match damage_element:
		damage_types.BLOOD:#USING SAME ENUM
			if enemy_type == damage_types.DEATH:
				player_damage /= 2
			elif enemy_type == damage_types.KNOWLEDGE:
				player_damage *= 2
			
		damage_types.DEATH:#USING SAME ENUM
			if enemy_type == damage_types.ENERGY:
				player_damage /= 2
			elif enemy_type == damage_types.BLOOD:
				player_damage *= 2
				
		damage_types.ENERGY:#USING SAME ENUM
			if enemy_type == damage_types.KNOWLEDGE:
				player_damage /= 2
			elif enemy_type == damage_types.DEATH:
				player_damage *= 2
		
		damage_types.KNOWLEDGE:#USING SAME ENUM
			if enemy_type == damage_types.BLOOD:
				player_damage /= 2
			elif enemy_type == damage_types.ENERGY:
				player_damage *= 2
			
		damage_types.PHYSICAL:
			pass
			
		_:
			player_damage *= 10
	
	return player_damage
