extends ProgressBar

@onready var hp_bar_label: Label = $hp_label
@onready var char: Player

func _ready() -> void:
	char = Global.player
	char.healthChange.connect(update)
	max_value = char.character_data.health
	value = char.character_data.health
	hp_bar_label.text = "%s / %s" % [value, max_value]


func update() -> void:
	max_value = char.max_health
	value = char.health
	
	hp_bar_label.text = "%s / %s" % [value, max_value]
