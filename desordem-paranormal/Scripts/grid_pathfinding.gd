extends Pathfinder

@export var tile_map: TileMapLayer
@export var field_size: Vector2i= Vector2i(40, 25)

# with strict mode enabled always follow the flowfield direction..
@export var strict_mode: bool= true

# .. otherwise go straight to the player unless the flowfields direction
# deviation from the direction to the player is greater than this angle
@export var max_deviation_angle: float= 30.0

@export var debug_mode: bool= false

@onready var max_deviation_angle_cos: float= cos(deg_to_rad(max_deviation_angle))

var flow_field: DirectionFlowField

var previous_player_grid_coords: Vector2i


func _ready() -> void:
	assert(tile_map, "Assign a Tile Map Layer to this Pathfinder")
	super()
	
	flow_field= DirectionFlowField.new(tile_map, field_size)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		queue_redraw()


func get_direction(from: Vector2)-> Vector2:
	var dir: Vector2= get_flowfield_direction(from)
	
	if not Global.pathfinder.strict_mode or not dir:
		var player_dir: Vector2= from.direction_to(Global.player.position)
		if not dir or player_dir.dot(dir) > max_deviation_angle_cos:
			dir= player_dir
	
	return dir


func get_flowfield_direction(from: Vector2)-> Vector2:
	if flow_field.rect.has_point(get_grid_coords(from)):
		return flow_field.get_direction(from)
	return Vector2.ZERO


func update(player_pos: Vector2, non_blocking: bool= true) -> void:
	if busy: return
	
	var player_grid_coords: Vector2i= get_grid_coords(player_pos)

	if previous_player_grid_coords and previous_player_grid_coords == player_grid_coords:
		return

	previous_player_grid_coords= player_grid_coords
	
	flow_field.build(player_grid_coords)


func _draw() -> void:
	if not debug_mode: return
	if not is_inside_tree() or not Global.player: return
	
	busy= true
	
	flow_field.debug_draw(self, tile_map, Color.RED)

	busy= false
