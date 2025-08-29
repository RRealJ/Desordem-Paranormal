extends Nex_upgrade


func apply_upgrade(element: Weapon) -> void:
	if element.weapon_stats.range_type == element.weapon_stats.range_types.MELEE:
		element.forca_opressora = true
