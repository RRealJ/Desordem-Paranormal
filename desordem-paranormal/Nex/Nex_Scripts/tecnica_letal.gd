extends Nex_upgrade


func apply_upgrade(element: Weapon) -> void:
	if element.weapon_stats.range_type == element.weapon_stats.range_types.MELEE and !element.tecnica_letal:
		element.crit_rate += 10.0
		element.tecnica_letal = true
