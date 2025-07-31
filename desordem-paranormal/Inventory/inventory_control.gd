extends Control

#funcionando, porém nao vai mostrar o item no inspector
@export var inventory: Inventory
@onready var item_slots_ui: Array[Node] = $"Panel/VScrollContainer/VBoxContainer".get_children()
@onready var stage: Node2D = $"../.."

func _ready() -> void:
	inventory.item_slots.clear()
	inventory.item_slots.resize(10)
	#insert_item(Global.player.main_weapon.weapon_stats.id) #for add main weapon of character


func insert_item(item_id: int) -> void:
	var item_found: Resource
	var index_slot: int = -1
	
	for item in Global.items_resources_avaible: # {resource.id : resource}
		item_found = item.get(item_id)
		if item_found:
			
			for i in range(inventory.item_slots.size()):
				
				if inventory.item_slots[i]  == null:
					inventory.item_slots[i] = Item_slot.new()
					inventory.item_slots[i].item = item_found
					index_slot = i
				
				else:
					if inventory.item_slots[i].item == item_found:
						inventory.item_slots[i].item.level += 1
						index_slot = i
						
				break	
		
		update_item_slots_ui(index_slot)
		break


func update_item_slots_ui(slot_index: int) -> void:
	if slot_index != -1:
		item_slots_ui[slot_index].item_res = inventory.item_slots[slot_index].item
		item_slots_ui[slot_index].update_item_slot()


func reset_items_level() -> void:  #call when player life reaches 0
	for i in range(inventory.item_slots.size()):
		if inventory.item_slots[i]  != null:
			inventory.item_slots[i].item.level = 1
			
	
