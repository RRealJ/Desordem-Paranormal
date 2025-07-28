extends Node2D

var arrow_sprite: Texture2D

enum elements {
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE
}

func change_pointer(element):
	var new_texture: String
	
	match element:
		elements.BLOOD:
			new_texture = "res://Assets/Sprites/Pointers/pointer_blood.png"
		elements.DEATH:
			new_texture = "res://Assets/Sprites/Pointers/pointer_death.png"
		elements.ENERGY:
			new_texture = "res://Assets/Sprites/Pointers/pointer_energy.png"
		elements.KNOWLEDGE:
			new_texture = "res://Assets/Sprites/Pointers/pointer_conhecimento.png"
		_:
			print("Element not found.")
			
	arrow_sprite = load(new_texture) as Texture2D
	if arrow_sprite is Texture2D:
		$Arrow.texture = arrow_sprite
	else:
		print("Invalid texture at path: ", new_texture)
		
	self.scale = Vector2(0.5, 0.5)
	
func _process(_delta):
	look_at(get_global_mouse_position())
