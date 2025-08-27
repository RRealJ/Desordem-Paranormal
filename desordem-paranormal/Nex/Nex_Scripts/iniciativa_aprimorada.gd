extends Nex_upgrade

var applied: bool = false
var boost: float

func apply_upgrade(_element: Weapon) -> void:
	if !applied:
		boost = Global.player.speed*(50/100)
		Global.player.speed += boost
		applied = true
		
	else:
		Global.player.speed -= boost
		boost = Global.player.speed*(50/100)
		Global.player.speed += boost
