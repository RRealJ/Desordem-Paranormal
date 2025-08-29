extends Nex_upgrade

var applied: bool = false
var nex_level: int
var life_boost: int

func apply_upgrade(_element: Weapon) -> void:
	
	nex_level = int(player.nex)
	life_boost = 5 * (int(nex_level / 5))
	
	if !applied:
		player.max_health += life_boost
		player.health += life_boost
		applied = true
	
	else:
		player.max_health -= life_boost
		player.health -= life_boost
		player.max_health += life_boost
		player.health += life_boost
