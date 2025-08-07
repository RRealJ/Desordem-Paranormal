extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var price_display: Label = $RichTextLabel/Label
@onready var player_upgrades: Array[Node] = $player_upgrades.get_children()
#@onready var stage_upgrades: Array[Node] = $stage_upgrades.get_children()
#@onready var monster_upgrades: Array[Node] = $monster_upgrades.get_children()


func _ready() -> void:
	var all_upgrades_slots: Array[Node] = []
#	all_upgrades_slots.append_array(player_upgrades)
#	all_upgrades_slots.append_array(stage_upgrades)
#	all_upgrades_slots.append_array(monster_upgrades)
	
#	for upgrade in all_upgrades_slots:
	for upgrade in player_upgrades:
		if upgrade.store_item_data:
			upgrade.button.focus_entered.connect(change_item_text_display.bind(upgrade))
		else:
			upgrade.button.disabled = true
			upgrade.button.focus_mode = Control.FOCUS_NONE
			
#	all_upgrades_slots = null, this way deletes from memory, if want to use it again, use .clear()
	

func change_item_text_display(upgrade:PanelContainer) -> void:
	rich_text_label.text = "%s\n\n%s" % [upgrade.store_item_data.store_item_name, upgrade.store_item_data.store_item_description]
	price_display.text = "Custo: %d" % [upgrade.store_item_data.price]
	
