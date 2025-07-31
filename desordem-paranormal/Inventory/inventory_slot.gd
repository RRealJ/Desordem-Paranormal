extends Control

@export var portrait_path: String
@export var item_res: Resource
@onready var rich_text: RichTextLabel = $Panel/HBoxContainer/RichTextLabel
@onready var panel: Panel = $Panel

const COLOR_BLOOD: Color = Color(0.66, 0.08, 0.0, 1)
const COLOR_DEATH: Color = Color(0.59, 0.6, 0.59, 1)
const COLOR_ENERGY: Color = Color(0.67, 0.29, 1, 1)
const COLOR_KNOWLEDGE: Color = Color(0.93, 0.71, 0.0, 1)


func _ready() -> void:
	var new_text: String
	
	new_text = highlight_word(item_res.description)
	rich_text.text = new_text
	
	match item_res.element_type:
		0:
			panel.self_modulate = COLOR_BLOOD
		1: 
			panel.self_modulate = COLOR_DEATH
		2:
			panel.self_modulate = COLOR_ENERGY
		3:
			panel.self_modulate = COLOR_KNOWLEDGE
		4: 
			pass
		_:
			panel.self_modulate = Color(0.93, 0.71, 0.0, 0)
	

func highlight_word(text: String) -> String:
	
	text = text.replace("sangue", "[color=%s]%s[/color]" % [COLOR_BLOOD.to_html(), "sangue"])
	text = text.replace("Sangue", "[color=%s]%s[/color]" % [COLOR_BLOOD.to_html(), "sangue".capitalize()])
	
	text = text.replace("morte", "[color=%s]%s[/color]" % [COLOR_DEATH.to_html(), "morte"])
	text = text.replace("Morte", "[color=%s]%s[/color]" % [COLOR_DEATH.to_html(), "morte".capitalize()])
	
	text = text.replace("energia", "[color=%s]%s[/color]" % [COLOR_ENERGY.to_html(), "energia"])
	text = text.replace("Energia", "[color=%s]%s[/color]" % [COLOR_ENERGY.to_html(), "energia".capitalize()])
	
	text = text.replace("conhecimento", "[color=%s]%s[/color]" % [COLOR_KNOWLEDGE.to_html(), "conhecimento".capitalize()])
	text = text.replace("Conhecimento", "[color=%s]%s[/color]" % [COLOR_KNOWLEDGE.to_html(), "conhecimento".capitalize()])
				
	return text
