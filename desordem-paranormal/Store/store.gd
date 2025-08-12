extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var price_display: Label = $RichTextLabel/Label
@onready var player_upgrades: Array[Node] = $player_upgrades.get_children()
@onready var confirm_panel: Panel = $Panel
#@onready var stage_upgrades: Array[Node] = $stage_upgrades.get_children()
#@onready var monster_upgrades: Array[Node] = $monster_upgrades.get_children()

var current_upgrade_tab: UPGRADE_TABS
var last_button: Button
var upgrade_selected: Node
var confirming: bool

enum UPGRADE_TABS {
	PLAYER,
	STAGE,
	ENEMY
}


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
			
	player_upgrades[0].button.grab_focus()
#	all_upgrades_slots = null, this way deletes from memory, if want to use it again, use .clear()
	

func change_item_text_display(upgrade:PanelContainer) -> void:
	rich_text_label.text = "%s\n\n%s" % [upgrade.store_item_data.store_item_name, upgrade.store_item_data.store_item_description]
	if upgrade.store_item_data.level < 7:
		price_display.text = "Custo: %d" % [upgrade.store_item_data.price]
	else:
		price_display.text = "Level\nMaximo"
	
	
func pop_confirm_screen(upgrade: Node) -> void:
	confirming = true
	confirm_panel.visible = true
	upgrade_selected = upgrade
	current_upgrade_tab = upgrade.upgrade_tab
	last_button = upgrade.button
	if upgrade_selected.store_item_data.level != 7:
		$Panel/Button2.text = "Não"
		$Panel/Button.text = "Sim"
		$Panel/RichTextLabel.text = "Confirmar compra de [color=#00e6e1]%s[/color] por [color=#f0cd00]%d[/color]?" % [(upgrade.store_item_data.store_item_name).capitalize() , upgrade.store_item_data.price]	
	else:
		$Panel/RichTextLabel.text = "[color=#de6bff]Level Maximo Atingido[/color]"
		$Panel/Button2.text = "Ok"
		$Panel/Button.text = "Ok"
	$Panel/Button.grab_focus()


func _on_confirm_button_pressed() -> void:
	if Global.money >= upgrade_selected.store_item_data.price:
		if upgrade_selected.store_item_data.level < 7:
			Global.money -= upgrade_selected.store_item_data.price
			update_money()
			upgrade_selected.store_item_data.level += 1
			upgrade_selected.update_item_display()
			StoreUpgrades.store_upgrade_var_update(upgrade_selected.store_item_data.id, upgrade_selected.store_item_data.level)
			upgrade_selected.save_store_item()
			print("Upgrade Confirmado")	
		else:
			print("Level Maximo Atingindo")
	else:
		print("Dinheiro Insuficiente")
	
	confirm_panel.visible = false
	confirming = false
	get_focus_to_last_button()
	
	
func _on_cancel_pressed() -> void:
	print("Upgrade Cancelado")
	confirm_panel.visible = false
	get_focus_to_last_button()
	confirming = false	


func update_money() -> void:
	$Label.text = str(Global.money)


func get_focus_to_last_button() -> void:
	match current_upgrade_tab:
		UPGRADE_TABS.PLAYER:
			last_button.grab_focus()
			
			
func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventAction:
		if event.is_action_pressed("ui_cancel"):
			if confirming:
				_on_cancel_pressed()
			
