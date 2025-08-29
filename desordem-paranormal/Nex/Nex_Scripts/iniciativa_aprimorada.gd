extends Nex_upgrade

var applied: bool = false
var boost: float

func apply_upgrade(_element: Weapon) -> void:
	boost = player.speed*(50/100)
	
	if !applied:
		player.speed += boost
		applied = true
		
	else:
		player.speed -= boost
		player.speed += boost
