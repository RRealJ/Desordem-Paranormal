extends Control

@onready var Array_of_buttons: Array[Button] = [
	$NinePatchRect/VBoxContainer/Jogar,
	$NinePatchRect/VBoxContainer/Opcoes,
	$NinePatchRect/VBoxContainer/Sair,
	$options_menu/NinePatchRect/VBoxContainer/audio,
	$options_menu/NinePatchRect/VBoxContainer/video,
	$options_menu/NinePatchRect/VBoxContainer/mix,
	$options_menu/NinePatchRect/back,
]


@onready var shader_rect: ColorRect = $ColorRect
@onready var options_menu: Control = $options_menu

var focus_button: Button

func _ready() -> void:
	options_menu.current_menu = $"."
	$NinePatchRect/VBoxContainer/Jogar.grab_focus()
	focus_button = $NinePatchRect/VBoxContainer/Jogar
	for button in Array_of_buttons:
		print(button)
		button.mouse_entered.connect(_grab_focus.bind(button))
		button.focus_entered.connect(correct_shader_position.bind(button))
	
	for button in $NinePatchRect/VBoxContainer.get_children():
		button.button_down.connect(button_is_pressed)
	

func _grab_focus(button:Button) -> void:
	if button != focus_button:
		button.grab_focus()
		focus_button = button


func correct_shader_position(button: Button) -> void:
	shader_rect.global_position = button.global_position
	shader_rect.size = Vector2(button.size.x, button.size.y + 2)
	shader_rect.material.set_shader_parameter("r_displacement", Vector2(4.0, 3.0))
	shader_rect.material.set_shader_parameter("g_displacement", Vector2(2.0, 0.0))
	shader_rect.material.set_shader_parameter("b_displacement", Vector2(-4.0, -3.0))


func button_is_pressed() -> void:
	shader_rect.material.set_shader_parameter("r_displacement", Vector2(6.0, 3.0))
	shader_rect.material.set_shader_parameter("g_displacement", Vector2(0.0, 0.0))
	shader_rect.material.set_shader_parameter("b_displacement", Vector2(-7.0, -4.0))
	

func _on_opcoes_pressed() -> void:
	options_menu.visible = true
	
	options_menu.button_audio.grab_focus()
	print("Entrando em options")


func _on_sair_pressed() -> void:
	get_tree().quit()
