extends Nex_upgrade

var applied: bool = false
var prev_dmg_boost: float = 0

func apply_upgrade(element: Weapon) -> void:
	if element.weapon_stats.weapon_type == element.weapon_stats.weapon_types.MAIN:
		if !applied:
			element.crit_rate += 200.0
			applied = true
			
		if element.crit_rate >= 105:
			var crit_rate:int = element.crit_rate - 100
			element.dmg_boost -= prev_dmg_boost
			element.dmg_boost += 10 * (crit_rate/5)
			prev_dmg_boost = 10 * (crit_rate/5)
			

#Aumenta a chance critica da Arma Principal em 200%, 
#a cada 5% de critico acima dos 100%, +10 de dano	
