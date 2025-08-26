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
