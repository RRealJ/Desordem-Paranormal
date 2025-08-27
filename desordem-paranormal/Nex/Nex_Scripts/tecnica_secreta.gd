extends Nex_upgrade


func apply_upgrade(element: Weapon) -> void:
	if !element.tecnica_secreta and element.weapon_stats.weapon_type == element.weapon_stats.weapon_types.MAIN:
		element.crit_modifier += 1
		element.tecnica_secreta = true
