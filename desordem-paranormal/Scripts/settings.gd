extends Node


var resolution_screen_index: int
var master_bus_value: float
var bgm_bus_value: float
var sfx_bus_value: float
var sfx_weapon_bus_value: float


func center_window() -> void:
	var screen_center := DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size := get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size/2)
