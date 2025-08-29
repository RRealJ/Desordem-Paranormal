extends Nex_upgrade

var prev_dmg_boost: int = 0

func apply_upgrade(element: Weapon) -> void:
	if element.weapon_stats.weapon_type == element.weapon_stats.weapon_types.MAIN:
		element.dmg_boost -= prev_dmg_boost
		element.dmg_boost += (5 * int(player.nex/5))
		prev_dmg_boost = 5 * int(player.nex/5)
