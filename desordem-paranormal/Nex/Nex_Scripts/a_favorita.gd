extends Nex_upgrade


func apply_upgrade(element: Weapon) -> void:
	if element.weapon_stats.weapon_type == element.weapon_stats.weapon_types.MAIN and !element.a_favorita:
		element.crit_rate += 25.0
		element.a_favorita = true
