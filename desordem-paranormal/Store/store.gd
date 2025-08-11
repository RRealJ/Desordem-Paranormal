extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var price_display: Label = $RichTextLabel/Label
@onready var player_upgrades: Array[Node] = $player_upgrades.get_children()
@onready var confirm_panel: Panel = $Panel
#@onready var stage_upgrades: Array[Node] = $stage_upgrades.get_children()
#@onready var monster_upgrades: Array[Node] = $monster_upgrades.get_children()

var upgrade_selected: Node

enum UPGRADE_TABS {
	PLAYER,
	STAGE,
	ENEMY
}

var current_upgrade_tab: UPGRADE_TABS

func _ready() -> void:
	update_money()
	var all_upgrades_slots: Array[Node] = []
#	all_upgrades_slots.append_array(player_upgrades)
#	all_upgrades_slots.append_array(stage_upgrades)
#	all_upgrades_slots.append_array(monster_upgrades)
	
#	for upgrade in all_upgrades_slots:
	for upgrade in player_upgrades:
		if upgrade.store_item_data:
			upgrade.button.focus_entered.connect(change_item_text_display.bind(upgrade))
			upgrade.button.pressed.connect(pop_confirm_screen.bind(upgrade))
		else:
			upgrade.button.disabled = true
			upgrade.button.focus_mode = Control.FOCUS_NONE
			
#	all_upgrades_slots = null, this way deletes from memory, if want to use it again, use .clear()
	

func change_item_text_display(upgrade:PanelContainer) -> void:
	rich_text_label.text = "%s\n\n%s" % [upgrade.store_item_data.store_item_name, upgrade.store_item_data.store_item_description]
	price_display.text = "Custo: %d" % [upgrade.store_item_data.price]
	
	
func pop_confirm_screen(upgrade: Node) -> void:
	$Panel/RichTextLabel.text = "Confirmar compra de [color=#00e6e1]%s[/color] por [color=#f0cd00]%d[/color]?" % [(upgrade.store_item_data.store_item_name).capitalize() , upgrade.store_item_data.price]
	confirm_panel.visible = true
	$Panel/Button.grab_focus()
	upgrade_selected = upgrade
	current_upgrade_tab = upgrade.upgrade_tab


func _on_confirm_button_pressed() -> void:
	if Global.money >= upgrade_selected.store_item_data.price:
		Global.money -= upgrade_selected.store_item_data.price
		update_money()
		upgrade_selected.store_item_data.level += 1
		upgrade_selected.update_item_display()
		StoreUpgrades.store_upgrade_var_update(upgrade_selected.store_item_data.id, upgrade_selected.store_item_data.level)
		upgrade_selected.save_store_item()
		print("confirmado")
		
	else:
		print("nuh-uh")
	
	confirm_panel.visible = false
	get_focus_to_current_upgrade_tab()
	

func update_money() -> void:
	$Label.text = str(Global.money)


func _on_button_2_pressed() -> void:
	print("upgrade cancelado")
	confirm_panel.visible = false
	get_focus_to_current_upgrade_tab()
	

func get_focus_to_current_upgrade_tab() -> void:
	match current_upgrade_tab:
		UPGRADE_TABS.PLAYER:
			$player_upgrades/StoreItem.button.grab_focus()
