extends Control

@export var nex_inventory: Inventory
@onready var item_slot: PackedScene = preload("res://Inventory/Item Slot/item_slot_ui.tscn")
@onready var nex_options_ui: Panel = $options_ui
@onready var nex_up_ui: Control = $nex_up_ui
@onready var item_slots_ui: Control = $options_ui/VScrollContainer/VBoxContainer

#@onready var stage: Node2D = $"../.."
#@onready var pause_menu_node: Node = $"../../Pause_menu/pause_menu"

var slots_ui_in_use: Array
var slots_in_nex_up_screen: Array[Node]
var current_nex_upgrade: Resource
var nex_done: Array[bool] = [false, false, false, false, false]


func _ready() -> void:
	nex_inventory.item_slots.clear()
	nex_inventory.item_slots.resize(50)
	slots_in_nex_up_screen = nex_up_ui.get_children()
#	nex_up(5)


func nex_up(level: int) -> void:
	var nex_level_done: bool
	match level:
		5: nex_level_done = nex_done[0]
		10: nex_level_done = nex_done[1]
		40: nex_level_done = nex_done[2]
		65: nex_level_done = nex_done[3]
		99: nex_level_done = nex_done[4]
		_: nex_level_done = true
			
	if !nex_level_done:
		nex_up_ui.visible = true
		var nex_upgrades: Array[Nex_stats] = get_nex_upgrades_from_level(level)
		
		if nex_upgrades.size() == 1:
			$nex_up_ui/nex_up_ui_slot.visible = false
			$nex_up_ui/nex_up_ui_slot2.visible = false
			$nex_up_ui/nex_up_ui_slot3.visible = false
			$nex_up_ui/nex_up_ui_slot4.visible = false
			$nex_up_ui/nex5.visible = true
			
			slots_in_nex_up_screen[4].nex_resource = nex_upgrades[0]
			slots_in_nex_up_screen[4].update_slot()
			slots_in_nex_up_screen[4].button.grab_focus()
			
			
		else:
			$nex_up_ui/nex_up_ui_slot.visible = true
			$nex_up_ui/nex_up_ui_slot2.visible = true
			$nex_up_ui/nex_up_ui_slot3.visible = true
			$nex_up_ui/nex_up_ui_slot4.visible = true
			$nex_up_ui/nex5.visible = false
			
			for i in range(4):
				slots_in_nex_up_screen[i].nex_resource = nex_upgrades[i]	
				slots_in_nex_up_screen[i].update_slot()
			
			slots_in_nex_up_screen[0].button.grab_focus()


func add_slot_ui(nex_upgrade: Nex_stats) -> void:
	current_nex_upgrade = nex_upgrade
	
	var new_item_slot := item_slot.instantiate()
	item_slots_ui.add_child(new_item_slot)
	update_slots_ui_children()
	
	insert_nex_upgrade_into_ui()
	
	Global.player.insert_nex_upgrade(current_nex_upgrade)
	print(Global.player.nex_upgrades)


func update_slots_ui_children() -> void:
	slots_ui_in_use = item_slots_ui.get_children()


func insert_nex_upgrade_into_ui() -> void:
	slots_ui_in_use[-1].item_res.item = current_nex_upgrade
	slots_ui_in_use[-1].update_item_slot()


func get_nex_upgrades_from_level(level: int) -> Array[Nex_stats]:
	var nex_upgrades_avaible: Array[Nex_stats]
	var folder_path: String
	
	match Global.player.character_data.types_of_characters:
	
		0: #Guerreiro
			folder_path = "res://Nex/Combatent/Resources/"
		1: #Especialista
			folder_path = "res://Nex/Specialist/Resources/"
		2: #Ocultista
			folder_path = "res://Nex/Ocultist/Resources/"
	
	match level:
		5:
			nex_done[0] = true
		10: 
			folder_path += "10"
			nex_done[1] = true
		40: 
			folder_path += "40"
			nex_done[2] = true
		65: 
			folder_path += "65"
			nex_done[3] = true
		99: 
			folder_path += "99"
			nex_done[4] = true
	
	print(folder_path)	
	var dir: DirAccess = DirAccess.open(folder_path)

	
	if dir:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tres"):
				
				var file_path: String = folder_path + "/" + file_name
				print(file_path)
				var res: Nex_stats = load(file_path)
				if res:
					
					nex_upgrades_avaible.append(res)
					
			file_name = dir.get_next()
		dir.list_dir_end()
		
	return nex_upgrades_avaible
	
