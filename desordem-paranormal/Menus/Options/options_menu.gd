extends Control

@onready var audio_menu: Control = $NinePatchRect/audio_menu
@onready var video_menu: Control = $NinePatchRect/video_menu
#@onready var mix_menu: Control = $NinePatchRect/mix_menu

@onready var current_menu: Control

@onready var button_audio: Button = $NinePatchRect/VBoxContainer/audio
@onready var button_video: Button = $NinePatchRect/VBoxContainer/video
@onready var button_mix: Button = $NinePatchRect/VBoxContainer/mix
@onready var button_back: Button = $NinePatchRect/back

var scene_original: Node
var go_back_to_menu: bool

func _ready() -> void:
	scene_original = $".."
	
	button_audio.focus_entered.connect(change_label_color.bind(button_audio, true))
	button_audio.focus_exited.connect(change_label_color.bind(button_audio, false))
	button_video.focus_entered.connect(change_label_color.bind(button_video, true))
	button_video.focus_exited.connect(change_label_color.bind(button_video, false))
	button_mix.focus_entered.connect(change_label_color.bind(button_mix, true))
	button_mix.focus_exited.connect(change_label_color.bind(button_mix, false))
	button_back.focus_entered.connect(change_label_color.bind(button_back, true))
	button_back.focus_exited.connect(change_label_color.bind(button_back, false))


func show_hide(show_it: Control) -> void:
	print("------------")
	print("Focusing on: ", show_it.name)
	
	if current_menu == scene_original:
		show_it.visible = true
		
	else:
		current_menu.visible = false
		show_it.visible = true	
		
	current_menu = show_it	
	print("changed current menu to: ", show_it.name)
	

func _on_mix_focus_entered() -> void:
	pass
	#show(mix_menu)


func _on_video_focus_entered() -> void:
	print("Focus Video")
	show_hide(video_menu)


func _on_audio_focus_entered() -> void:
	print("Focus Audio")
	show_hide(audio_menu)


func _on_back_pressed() -> void:
	print("going to main menu")
	$".".visible = false
	scene_original.visible = true
	audio_menu.visible = false
	video_menu.visible = false
	#mix_menu.visible = false
	$"../NinePatchRect/VBoxContainer".visible = true
	scene_original.Array_of_buttons[0].grab_focus()
	current_menu = scene_original


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if !go_back_to_menu:
			match current_menu.name:
				"audio_menu":
					button_audio.grab_focus()
				"video_menu":
					button_video.grab_focus()
				"mix_menu":
					button_mix.grab_focus()
				"_":
					print("no menu")
				
	elif event.is_action_pressed("ui_accept"):
		if !go_back_to_menu:
			match current_menu.name:
				"audio_menu":
					audio_menu.sliders[audio_menu.index_focus_button].grab_focus()
				"video_menu":
					video_menu.buttons[video_menu.index_focus_button].grab_focus()
				"mix_menu":
					button_mix.grab_focus()
		


func change_label_color(button: Button, entering_focus: bool) -> void:
		if entering_focus:
			button.modulate = Color(0.93, 0.71, 0.0, 1)
			return
		button.modulate = Color(1, 1, 1, 1)


func _on_back_focus_entered() -> void:
	go_back_to_menu = true


func _on_back_focus_exited() -> void:
	go_back_to_menu = false
