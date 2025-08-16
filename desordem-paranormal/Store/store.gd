extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var price_display: Label = $RichTextLabel/Label
@onready var player_upgrades: Array[Node] = $player_upgrades.get_children()
@onready var stage_upgrades: Array[Node] = $stage_upgrades.get_children()
@onready var monster_upgrades: Array[Node] = $monster_upgrades.get_children()

var confirm_panel: Panel
var last_button: Button
var last_main_button: Button
var upgrade_selected: Node
var current_upgrade_grid: GridContainer
var confirming: bool
var highlight_button: Button

func _ready() -> void:
	update_money()
	confirm_panel = $Panel
	var all_upgrades_slots: Array[Node] = []
	all_upgrades_slots.append_array(player_upgrades)
	all_upgrades_slots.append_array(stage_upgrades)
	all_upgrades_slots.append_array(monster_upgrades)
	
	for upgrade in all_upgrades_slots:
		if upgrade.store_item_data:
			upgrade.button.focus_entered.connect(change_item_text_display.bind(upgrade))
			upgrade.button.pressed.connect(pop_confirm_screen.bind(upgrade))
		else:
			upgrade.button.disabled = true
			upgrade.button.focus_mode = Control.FOCUS_NONE
			
	player_upgrades[0].button.grab_focus()
	
	$HBoxContainer/Player.focus_entered.connect(focus_main_button.bind($HBoxContainer/Player))
	$HBoxContainer/Stage.focus_entered.connect(focus_main_button.bind($HBoxContainer/Stage))
	$HBoxContainer/Monster.focus_entered.connect(focus_main_button.bind($HBoxContainer/Monster))
	
	all_upgrades_slots.clear()
	

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
	last_button = upgrade.button
	if upgrade_selected.store_item_data.level != 7:
		$Panel/Button.text = "Sim"
		$Panel/Button2.text = "Não"
		$Panel/RichTextLabel.text = "Confirmar compra de [color=#00e6e1]%s[/color] por [color=#f0cd00]%d[/color]?" % [(upgrade.store_item_data.store_item_name).capitalize() , upgrade.store_item_data.price]	
	else:
		$Panel/RichTextLabel.text = "[color=#de6bff]Level Maximo Atingido[/color]"
		$Panel/Button.text = "Ok"
		$Panel/Button2.text = "Refund"
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
	if upgrade_selected.store_item_data.level == 7:
		Global.money += 15469
		update_money()
		upgrade_selected.store_item_data.level = 0
		upgrade_selected.update_item_display()
		StoreUpgrades.store_upgrade_var_update(upgrade_selected.store_item_data.id, upgrade_selected.store_item_data.level)
		upgrade_selected.save_store_item()
		print("Upgrade Refounded")	
		
	else:
		print("Upgrade Cancelado")	
		
	confirm_panel.visible = false
	get_focus_to_last_button()
	confirming = false	


func update_money() -> void:
	$Label.text = str(Global.money)


func get_focus_to_last_button() -> void:
	last_button.grab_focus()
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventAction:
		if event.is_action_pressed("ui_cancel"):
			if confirming and upgrade_selected.store_item_data.level != 7:
				_on_cancel_pressed()
			elif confirming and upgrade_selected.store_item_data.level == 7:
				_on_confirm_button_pressed()
				
			if !confirming:
				last_main_button.grab_focus()
			
	
func focus_main_button(button: Button) -> void:
	if current_upgrade_grid:
		current_upgrade_grid.visible = false
	
	match button.name:
		"Player":
			current_upgrade_grid = $player_upgrades
		"Stage":
			current_upgrade_grid = $stage_upgrades
		"Monster": 
			current_upgrade_grid = $monster_upgrades
	
	current_upgrade_grid.visible = true
	
	last_main_button = button
	if !highlight_button:
		highlight_button = button
	else:
		button.add_theme_color_override("font_color", Color(0.94, 0.80, 0, 1))
		highlight_button.add_theme_color_override("font_color", Color(0.85, 0.85, 0.85, 1))
		highlight_button = button
		

func _on_button_pressed() -> void:
	player_upgrades[0].grab_focus()


func _on_button_2_pressed() -> void:
	pass
	#stage_upgrades[0].grab_focus()


func _on_button_3_pressed() -> void:
	pass
	#monster_upgrades[0].grab_focus()
