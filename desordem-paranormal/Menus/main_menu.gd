extends Control

@onready var Array_of_buttons: Array[Button] = [
	$NinePatchRect/VBoxContainer/Jogar,
	$NinePatchRect/VBoxContainer/Opcoes,
	$NinePatchRect/VBoxContainer/Sair
]

@onready var shader_rect: ColorRect = $ColorRect

var focus_button: Button


func _ready() -> void:
	$NinePatchRect/VBoxContainer/Jogar.grab_focus()
	focus_button = $NinePatchRect/VBoxContainer/Jogar
	for button in Array_of_buttons:
		button.mouse_entered.connect(_grab_focus.bind(button))
		button.focus_entered.connect(correct_shader_position.bind(button))
	

func _grab_focus(button:Button) -> void:
	if button != focus_button:
		button.grab_focus()
		focus_button = button


func correct_shader_position(button: Button) -> void:
	shader_rect.global_position = button.global_position
	shader_rect.size = Vector2(button.size.x, button.size.y + 2)
