class_name Nex_stats
extends Resource

@export var id: int
@export var name: String
@export var nex_level: int
@export var sub_class: String
@export var class_type: class_types
@export var element_type: element_types
@export var description: Array[String]
@export var portrait_path: String
@export var nex_scene: PackedScene

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

enum class_types {
	GUERREIRO,
	ESPECIALISTA,
	OCULTISTA
}
