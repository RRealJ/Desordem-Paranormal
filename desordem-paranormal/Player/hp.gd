extends ProgressBar

@onready var hp_bar_label: Label = $hp_label
@onready var char: Player = $"../../.."

func _ready() -> void:
	char.healthChange.connect(update)
	max_value = char.character_data.health
	value = char.character_data.health
	hp_bar_label.text = "%s / %s" % [value, max_value]


func update() -> void:
	max_value = char.health
	value = char.health
	print(max_value, char.health)
	print(value, char.health)
	
	hp_bar_label.text = "%s / %s" % [value, max_value]
