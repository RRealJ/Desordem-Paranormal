extends Resource
class_name Weapon_stats

@export var name: String
@export var damage: int
@export var range_type: range_types
@export var dmg_type: dmg_types
@export var ammo: int
@export var max_ammo: int
@export var attack_cooldown: int
@export var awaken: bool

enum range_types {
	MELEE,
	RANGED,
	AREA
}

enum dmg_types{
	PHYSICAL,
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE
}
