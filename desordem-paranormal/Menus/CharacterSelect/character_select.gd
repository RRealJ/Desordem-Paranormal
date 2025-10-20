extends Control

@onready var element_select: TextureRect = $ColorRect/VBoxContainer/HBoxContainer/Elemento

var character_focus: Character_data
var character_select_sprite: CHARACTER_SELECT
var button_focus: TextureButton

enum CHARACTER_SELECT{
	JOUI,
	KAISER,
	ERIN,
	ARNALDO,
	AGATHA
}

enum CLASS{
	GUERREIRO,
	ESPECIALISTA,
	OCULTISTA
}

enum ELEMENT{
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEGDE,
	PHYSICAL
}

func _ready() -> void:
	character_focus = $character_grid/BntCharacterSelect.character_data
	for button in $character_grid.get_children():
		button.character_focus_changed.connect(update_character_display)
		
	update_character_display()
	$character_grid/BntCharacterSelect.grab_focus()


func update_character_display() -> void:
	if button_focus:
		#update_sprites()
		$character_name.text = character_focus.name
		$ColorRect/VBoxContainer/HBoxContainer/HBoxContainer/hp.text = str(character_focus.health)
		$ColorRect/VBoxContainer/HBoxContainer/HBoxContainer2/speed.text = str(int(character_focus.speed))
		$ColorRect/VBoxContainer/HBoxContainer2/crit_chance.text = str(character_focus.crit_rate)
		#$ColorRect/VBoxContainer/HBoxContainer2/crit_chance_label.text = change translation
		$ColorRect/VBoxContainer/HBoxContainer3/crit_multi.text = str(character_focus.crit_modify)
		#$ColorRect/VBoxContainer/HBoxContainer3/crit_multi_label.text = change translation
		update_images(character_focus.portrait, character_focus.type_of_character, character_focus.element_of_character)


func update_images(new_portrait: String, new_class: int, new_element: int) -> void:
	var image: Texture2D# = load(new_portrait) as Texture2D
	#$ColorRect/portrait.texture = image
	
	match new_element:
		ELEMENT.BLOOD:
			image = load("res://Assets/Sprites/elements/blood_char_select.png") as Texture2D
		ELEMENT.DEATH:
			pass
		ELEMENT.ENERGY:
			pass
		ELEMENT.KNOWLEGDE:
			pass
		ELEMENT.PHYSICAL:
			pass
	
	element_select.texture = image
	
	match new_class:
		CLASS.GUERREIRO:
			pass
			#image = load() as Texture2D
		CLASS.ESPECIALISTA:
			pass
		CLASS.OCULTISTA:
			pass
			
	#$ColorRect/class_icon.texture = image


func update_sprites() -> void: # basicamente vai show/hide o animated sprite
	match character_select_sprite:
		
		CHARACTER_SELECT.JOUI:
			pass
		CHARACTER_SELECT.KAISER:
			pass
		CHARACTER_SELECT.ERIN:
			pass
		CHARACTER_SELECT.ARNALDO:
			pass
		CHARACTER_SELECT.AGATHA:
			pass	


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/Main/main_menu.tscn")
