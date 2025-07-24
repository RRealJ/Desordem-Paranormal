extends Node2D

var arrow_sprite: Texture2D


func change_pointer(new_texture):
	arrow_sprite = load(new_texture) as Texture2D
	if arrow_sprite is Texture2D:
		$Arrow.texture = arrow_sprite
	else:
		print("Invalid texture at path: ", new_texture)
	
func _process(_delta):
	look_at(get_global_mouse_position())
