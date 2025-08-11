extends Node


#Player
var life_upgrade: int = 0
var critrate_upgrade: int = 0
var speed_upgrade: int = 0
var luck_upgrade: int = 0
var recharge_upgrade: int = 0


func store_upgrade_var_update(id: int, level: int) -> void:
	match id:
		0:
			life_upgrade = level	
