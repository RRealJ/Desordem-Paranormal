extends Resource
class_name Weapon_stats

@export var name: String
@export var damage: int
@export var speed: int
@export var weapon_type: weapon_types
@export var range_type: range_types
@export var dmg_type: dmg_types
@export var attack_cooldown: int
@export var awaken: bool

enum range_types {
	MELEE,
	RANGED,
	OCULTISM
}

enum dmg_types{
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE,
	PHYSICAL
}

enum weapon_types{
	MAIN,
	PICKABLE
}
