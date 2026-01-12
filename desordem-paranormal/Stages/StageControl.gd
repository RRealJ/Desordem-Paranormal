extends Node2D


@onready var enemy_controller: Spawner = $enemy_controller
@onready var enemies: Node2D = $Enemies
@export var pause_below_n_fps: int= 20

var player: Player

func _init() -> void:
	Global.stage = self


func _ready() -> void:
	print("Fetching Character")
	var new_character := Global.character_selected.instantiate()
	new_character.global_position = $player_spawn.global_position
	$".".add_child(new_character)
	
	print("Character Fetched Sucessfully")
	$Nex_ui/nex_control.adjustCharacter()
	
	player = Global.player
	
	Global.enemies = enemies
	enemy_controller.create_spawner(enemy_controller.enemy_spawners_data[0])
