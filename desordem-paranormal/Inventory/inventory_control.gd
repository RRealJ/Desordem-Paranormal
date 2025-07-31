extends Control

#funcionando, porém nao vai mostrar o item no inspector
@export var inventory: Inventory
@onready var item_slot_ui: PackedScene = preload("res://Inventory/Item Slot/item_slot_ui.tscn")
@onready var stage: Node2D = $"../.."

var player: CharacterBody2D

func _ready() -> void:
	player = Global.player
	inventory.item_slots.clear()
	inventory.item_slots.resize(10)
	insert_item(player.main_weapon.weapon_stats.id)


func insert_item(item_id: int) -> void:
	var item_found: Resource
	
	for item in Global.items_resources_avaible: # {resource.id : resource}
		item_found = item.get(item_id)
		if item_found:
			
			for i in range(inventory.item_slots.size()):
				
				if inventory.item_slots[i]  == null:
					inventory.item_slots[i] = Item_slot.new()
					inventory.item_slots[i].item = item_found
					break
				
				else:
					if inventory.item_slots[i].item == item_found:
						inventory.item_slots[i].item.level += 1
						break
						
			break

func reset_items_level_and_clean_inventory() -> void:  #call when player life reaches 0
	for i in range(inventory.item_slots.size()):
		if inventory.item_slots[i]  != null:
			inventory.item_slots[i].item.level = 1
