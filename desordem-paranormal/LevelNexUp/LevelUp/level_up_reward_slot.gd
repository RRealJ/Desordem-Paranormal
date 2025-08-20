extends Panel

@onready var item: Resource
@onready var reward_control := $".."
@onready var level_label: RichTextLabel = $level
@onready var range_label: Label = $range
@onready var cooldown_label: Label = $cooldown
@onready var awaken_label: Label = $awaken
@onready var description: RichTextLabel = $description
@onready var button: Button = $Button

const COLOR_BLOOD: Color = Color(0.66, 0.08, 0.0, 1)
const COLOR_DEATH: Color = Color(0.59, 0.6, 0.59, 1)
const COLOR_ENERGY: Color = Color(0.67, 0.29, 1, 1)
const COLOR_KNOWLEDGE: Color = Color(0.93, 0.71, 0.0, 1)


func _ready() -> void:
	item = load("res://Weapon/Resources/katana_erosiva.tres")
	update_slot()


func update_slot() -> void:
	update_level_label(item.level)
	update_range_label(item.range_type)
	cooldown_label.text = str(item.attack_cooldown)
	update_awaken_label(item.awaken)
	update_portrait(item.portrait_path)
	update_description()


func update_level_label(level: int) -> void:
	var new_level: String = "[color=purple]"
	
	for i in range(level):
		new_level += "/"
		
	new_level += "[/color]"
	new_level += "[color=orange]/[/color]"
	
	if level != 7:
		for i in range(7-(level+1)):
			new_level += "/"
			
	level_label.text = new_level


func update_range_label(range: int) -> void:
	match range:
		0: #melee
			range_label.text = "Curto"
		1: #ranged
			range_label.text = "Longo"
		2: #ocultism
			range_label.text = "Ocult"
		_:
			print("Range fora dos limites")
			range_label.text = "NO"
			

func update_awaken_label(awaken: bool) -> void:
	var color: Color
	if awaken:
		match item.element_type:
			0: #blood
				color = COLOR_BLOOD
			1: #death
				color = COLOR_DEATH
			2: #energy
				color = COLOR_ENERGY
			3: #knowledge
				color = COLOR_KNOWLEDGE
		
		awaken_label.modulate = color


func update_portrait(new_texture: String) -> void:
	if !new_texture:
		new_texture = "res://Assets/32x32.png"
	var image: Texture2D = load(new_texture) as Texture2D
	$ItemIcon.texture = image	


func update_description() -> void:
	var new_description: String = item.description[item.level-1]
	new_description = highlight_word(new_description)
	description.text = new_description
	
	
func highlight_word(text: String) -> String:
	
	#Trocar palavra por variavel word do arquivo de tradução
	
	text = text.replace("sangue", "[color=%s]%s[/color]" % [COLOR_BLOOD.to_html(), "sangue"])
	text = text.replace("Sangue", "[color=%s]%s[/color]" % [COLOR_BLOOD.to_html(), "sangue".capitalize()])
	
	text = text.replace("morte", "[color=%s]%s[/color]" % [COLOR_DEATH.to_html(), "morte"])
	text = text.replace("Morte", "[color=%s]%s[/color]" % [COLOR_DEATH.to_html(), "morte".capitalize()])
	
	text = text.replace("energia", "[color=%s]%s[/color]" % [COLOR_ENERGY.to_html(), "energia"])
	text = text.replace("Energia", "[color=%s]%s[/color]" % [COLOR_ENERGY.to_html(), "energia".capitalize()])
	
	text = text.replace("conhecimento", "[color=%s]%s[/color]" % [COLOR_KNOWLEDGE.to_html(), "conhecimento".capitalize()])
	text = text.replace("Conhecimento", "[color=%s]%s[/color]" % [COLOR_KNOWLEDGE.to_html(), "conhecimento".capitalize()])
				
	return text	
	

func _on_button_focus_entered() -> void:
	material.set_shader_parameter("enabled", true)
#	$ItemIcon.material.set_shader_parameter("enabled", true)
	

func _on_button_focus_exited() -> void:
	material.set_shader_parameter("enabled", false)
#	$ItemIcon.material.set_shader_parameter("enabled", false)
	
	
func item_deleted() -> void:
	item = null
	$ItemIcon.texture = null
	level_label.text = "///////"
	range_label.text = "-"
	cooldown_label.text = "-"
	awaken_label.text = "XXXXX"
	description.text = "Item Deletado."
	
	
func _on_button_pressed() -> void:
	if item:
		reward_control.seleted_item(item)
