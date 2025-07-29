extends Resource
class_name Enemy_data

@export var name: String
@export var health: int
@export var speed: float
@export var damage: int
@export var enemy_type: damage_types

enum damage_types {
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE,
	PHYSICAL
}
