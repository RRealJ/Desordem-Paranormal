extends Panel

@export var nex_resource: Nex_stats

@onready var name_label: Label = $name_label
@onready var description: RichTextLabel = $RichTextLabel
@onready var subclass: Label = $caminho

@onready var button: Button = $Button
@onready var portrait: TextureRect = $TextureRect

func _ready() -> void:
	update_slot()

func update_slot() -> void:
	name_label.text = nex_resource.name
	description.text = nex_resource.description[0]
	
	subclass.text = nex_resource.sub_class
	
	var new_image: Texture2D = load(nex_resource.portrait_path) as Texture2D
	portrait.texture = new_image


func _on_button_focus_entered() -> void:
	$NinePatchRect.self_modulate = Color(0.8, 0.94, 0.9, 1)


func _on_button_focus_exited() -> void:
	$NinePatchRect.self_modulate = Color(1, 1, 1, 1)


func _on_button_pressed() -> void:
	$"../..".add_slot_ui(nex_resource)
