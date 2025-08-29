extends Nex_upgrade

var applied: bool = false

func apply_upgrade(element: Weapon) -> void:
	if element.weapon_stats.weapon_type == element.weapon_stats.weapon_types.MAIN and !applied:
		element.crit_rate += 80.0
		applied = true
