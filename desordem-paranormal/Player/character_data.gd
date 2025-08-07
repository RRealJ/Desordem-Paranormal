extends Resource
class_name Character_data

@export var name: String
@export var health: int
@export var speed: float
@export var level: int
@export var crit_rate: float
@export var crit_modify: float
@export var type_of_character: types_of_characters
@export var element_of_character: elements_of_characters
@export var luck: float


enum types_of_characters {
	GUERREIRO,
	ESPECIALISTA,
	OCULTISTA
}

enum elements_of_characters {
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE,
	PHYSICAL
}
