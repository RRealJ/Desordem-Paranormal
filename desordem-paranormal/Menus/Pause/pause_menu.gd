extends Control

@onready var inventory_node: Node = $"../../Inventory_Ui/inventory_control"
@onready var last_button: Button = $VBoxContainer/Resume

var is_paused: bool = false

func _on_resume_pressed() -> void:
	last_button = $VBoxContainer/Resume
	get_tree().paused = false
	visible = false


func _on_inventory_pressed() -> void:
	last_button = $VBoxContainer/Inventory
	inventory_node.visible = true
	visible = false
	inventory_node.item_slots_ui[0].button.grab_focus()


func _on_options_pressed() -> void:
	last_button = $VBoxContainer/Options
	pass


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/Main/main_menu.tscn")
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_back"):
		if is_paused:
			is_paused = false
			visible = false
			get_tree().paused = false
		else:
			last_button.grab_focus()
			is_paused = true
			visible = true
			get_tree().paused = true
