extends TextureButton

signal character_focus_changed

@export var character_data: Character_data
@export var character_sprite: CHARACTER_SELECT
@export var character_scene: PackedScene
@export var unlocked: bool


enum CHARACTER_SELECT{
	JOUI,
	KAISER,
	ERIN,
	ARNALDO,
	AGATHA
}


func _ready() -> void:
	match character_sprite:
		CHARACTER_SELECT.JOUI:
			unlocked = true
			
		CHARACTER_SELECT.KAISER:
			unlocked = Global.kaiser
			
		CHARACTER_SELECT.ERIN:
			unlocked = Global.erin
			
		CHARACTER_SELECT.ARNALDO:
			unlocked = Global.arnaldo
			
		CHARACTER_SELECT.AGATHA:
			unlocked = Global.agatha



func _on_focus_entered() -> void:
	$"../..".button_focus = self 
	$"../..".character_focus = character_data
	$"../..".character_select_sprite = character_sprite
	emit_signal("character_focus_changed")
	

func _on_pressed() -> void:
	Global.character_selected = character_scene
	get_tree().change_scene_to_file("res://Stages/area_testes.tscn")
