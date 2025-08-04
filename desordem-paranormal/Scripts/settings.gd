extends Node

#AUDIO
var master_bus_value: float
var bgm_bus_value: float
var sfx_bus_value: float
var sfx_weapon_bus_value: float
#VIDEO
var resolution_screen_index: int
var isVsyncOn: bool
var isFullscreen: bool


func center_window() -> void:
	var screen_center := DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size := get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size/2)
