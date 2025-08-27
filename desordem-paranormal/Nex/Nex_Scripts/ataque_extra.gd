extends Nex_upgrade


func apply_upgrade(element: Weapon) -> void:
	if element.weapon_stats.weapon_type == element.weapon_stats.weapon_types.MAIN:
		element.extra_attack1 = true
