extends Control


@onready var hp_bar: ProgressBar = $hp
@onready var char_portrait: TextureRect = $portrait
@onready var items_portrait: GridContainer = $items_portrait
@onready var nex_progress: TextureProgressBar = $nex_progress
@onready var char: Player = $"../.."


func _ready() -> void:
	hp_bar.max_value = char.health
	hp_bar.value = char.health

	
	var image: Texture2D = load(char.character_data.portrait) as Texture2D
	char_portrait.texture = image
