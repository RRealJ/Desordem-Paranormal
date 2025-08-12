extends Node


#Player
var life_upgrade: int = 0
var speed_upgrade: int = 0
var critrate_upgrade: int = 0
var luck_upgrade: int = 0
var recharge_upgrade: int = 0


func _ready() -> void:
	load_upgrades()
	

func store_upgrade_var_update(id: int, level: int) -> void:
	if id:
		match id:
			0:
				life_upgrade = level
			1:
				speed_upgrade = level
			2:
				critrate_upgrade = level
			3:
				luck_upgrade = level
			4:
				recharge_upgrade = level


func load_upgrades() -> void:
	var dir := DirAccess.open("user://Store_upgrades/")
	if dir == null:
		push_error("Could not open folder: user://Store_upgrades/")
		return
	
	dir.list_dir_begin()
	var file_name := dir.get_next()
	
	while file_name != "":
		if not dir.current_is_dir():
			print("Found file: ", file_name)
			var upgrade_resource: Resource = load("user://Store_upgrades/".path_join(file_name)) 
			store_upgrade_var_update(upgrade_resource.id, upgrade_resource.level)
		file_name = dir.get_next()
	
	dir.list_dir_end()
