extends Nex_upgrade

var applied: bool = false
var nex_level: int = int(Global.player.nex)
var life_boost: int = 5 * (int(nex_level / 5))

func apply_upgrade(_element: Weapon) -> void:
	if !applied:
		nex_level = int(Global.player.nex)
		life_boost = 5 * (int(nex_level / 5))
		Global.player.max_health += life_boost
		Global.player.health += life_boost
		applied = true
	
	else:
		Global.player.max_health -= life_boost
		Global.player.health -= life_boost
		nex_level = int(Global.player.nex)
		life_boost = 5 * (int(nex_level / 5))
		Global.player.max_health += life_boost
		Global.player.health += life_boost
