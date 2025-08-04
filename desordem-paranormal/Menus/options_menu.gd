extends Control

@onready var audio_menu: Control = $NinePatchRect/audio_menu
@onready var video_menu: Control = $NinePatchRect/video_menu
#@onready var mix_menu: Control = $NinePatchRect/mix_menu
@onready var current_menu: Control = $"../NinePatchRect/VBoxContainer"


@onready var button_audio: Button = $NinePatchRect/VBoxContainer/audio
@onready var button_video: Button = $NinePatchRect/VBoxContainer/video
@onready var button_mix: Button = $NinePatchRect/VBoxContainer/mix

var menu_original: Node 

func _ready() -> void:
	menu_original = $".."


func show_hide(show_it: Control, goingBack: bool = false) -> void:
	if goingBack:
		$".".visible = false
		$"..".visible = true
		menu_original.visible = true
		$"..".Array_of_buttons[0].grab_focus()
		return
		
	current_menu.visible = false
	show_it.visible = true
	current_menu = show_it
	

func _on_mix_focus_entered() -> void:
	pass
	#show(mix_menu)


func _on_video_focus_entered() -> void:
	show_hide(video_menu)


func _on_audio_focus_entered() -> void:
	show_hide(audio_menu)


func _on_back_pressed() -> void:
	show_hide($"..", true)
