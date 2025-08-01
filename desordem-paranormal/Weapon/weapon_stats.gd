extends Resource
class_name Weapon_stats

@export var id: int
@export var name: String
@export var damage: int
@export var speed: int
@export var weapon_type: weapon_types
@export var range_type: range_types
@export var element_type: element_types
@export var attack_cooldown: int
@export var awaken: bool
@export var level: int = 1
@export var description: String
@export var portrait_path: String
@export var bullet_scene: PackedScene

enum range_types {
	MELEE,
	RANGED,
	OCULTISM
}

enum element_types{
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
