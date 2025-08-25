extends Control

@export var nex_inventory: Inventory
@onready var item_slot: PackedScene = preload("res://Inventory/Item Slot/item_slot_ui.tscn")
@onready var item_slots_ui: Control = $Panel/VScrollContainer/VBoxContainer
#@onready var stage: Node2D = $"../.."
#@onready var pause_menu_node: Node = $"../../Pause_menu/pause_menu"

var slots_ui_in_use: Array
var current_nex_upgrade: Resource

func _ready() -> void:
	nex_inventory.item_slots.clear()
	nex_inventory.item_slots.resize(50)


func add_slot_ui(nex_upgrade: Nex_stats) -> void:
	current_nex_upgrade = nex_upgrade
	
	var new_item_slot := item_slot.instantiate()
	item_slots_ui.add_child(new_item_slot)
	update_slots_ui()
	
	insert_nex_upgrade_into_ui()


func update_slots_ui() -> void:
	slots_ui_in_use = item_slots_ui.get_children()


func insert_nex_upgrade_into_ui() -> void:
	slots_ui_in_use[-1].item_res.item = current_nex_upgrade
	slots_ui_in_use[-1].update_item_slot()
