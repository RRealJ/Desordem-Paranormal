extends Control

@onready var audio_menu: Control = $NinePatchRect/audio_menu
#@onready var video_menu: Control = $NinePatchRect/video_menu
#@onready var mix_menu: Control = $NinePatchRect/mix_menu

@onready var current_menu: Control = $NinePatchRect/audio_menu


func _on_audio_button_down() -> void:
	show_hide(audio_menu)


func _on_video_button_down() -> void:
	pass
	#show_hide(video_menu)


func _on_mix_button_down() -> void:
	pass
	#show_hide(mix_menu)


func show_hide(show_it: Control) -> void:
	current_menu.visible = false
	show_it.visible = true
	current_menu = show_it
