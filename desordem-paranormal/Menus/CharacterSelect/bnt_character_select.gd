extends TextureButton

signal character_focus_changed

@export var character_data: Character_data
@export var character_sprite: CHARACTER_SELECT


enum CHARACTER_SELECT{
	JOUI,
	KAISER,
	ERIN,
	ARNALDO,
	AGATHA
}

func _on_focus_entered() -> void:
	$"../..".character_focus = character_data
	$"../..".character_sprite_select = character_sprite
	emit_signal("character_focus_changed")
	
