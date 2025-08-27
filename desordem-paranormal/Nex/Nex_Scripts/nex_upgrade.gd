class_name Nex_upgrade
extends Node

@export var type: types_stats

var player: Player

enum types_stats {
	MAIN_WEAPON,
	PICKABLE_WEAPON,
	EQUIPS,
	RITUALS,
	GENERAL_DMG,
	PLAYER	
}

func _ready() -> void:
	player = Global.player
