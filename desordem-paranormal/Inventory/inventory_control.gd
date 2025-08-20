extends Control

#funcionando, porém nao vai mostrar o item no inspector
@export var inventory: Inventory
@onready var item_slots_ui: Array[Node] = $"Panel/VScrollContainer/VBoxContainer".get_children()
@onready var stage: Node2D = $"../.."


func _ready() -> void:
	inventory.item_slots.clear()
	inventory.item_slots.resize(10)
	
	set_focus()
	#insert_item(Global.player.main_weapon.weapon_stats.id) #for add main weapon of character


func insert_item(item: Resource) -> void:
	var index_slot: int = -1
	var update_only_level_ui: bool = false
	
	if item:
		for i in range(inventory.item_slots.size()):
			
			if inventory.item_slots[i] == null:
				print("Inventory slot null - adding item_found")
				inventory.item_slots[i] = Item_slot.new()
				inventory.item_slots[i].item = item
				index_slot = i	#default value is -1, needs to be in there
				print(inventory.item_slots[i].item)
				break
				
			elif inventory.item_slots[i].item == item:
				#inventory.item_slots[i].item.level += 1 #ver se precisa colocar 
				update_only_level_ui = true
				index_slot = i #default value is -1, needs to be in there
				break
												
	update_item_slots_ui(index_slot, update_only_level_ui)
	


func update_item_slots_ui(index_slot: int, only_level: bool) -> void:
	if index_slot != -1:
		
		if only_level:
			item_slots_ui[index_slot].update_item_level()
			return

		item_slots_ui[index_slot].item_res.item = inventory.item_slots[index_slot].item
		item_slots_ui[index_slot].update_item_slot()


func reset_items_level() -> void:  #call when player life reaches 0
	for i in range(inventory.item_slots.size()):
		if inventory.item_slots[i]  != null:
			
			if inventory.item_slots[i].item.weapon_type == 0:
				inventory.item_slots[i].item.level = 1
			else:
				inventory.item_slots[i].item.level = 0
			

func set_focus() -> void:
	var item_slots_paths: Array[NodePath]
	for item in item_slots_ui:
		item_slots_paths.append(item.button.get_path())
		
	for i:int in range(item_slots_paths.size()):
		if i != 0:
			item_slots_ui[i].button.set_focus_neighbor(SIDE_TOP, item_slots_paths[i-1])
			item_slots_ui[i].button.set_focus_neighbor(SIDE_LEFT, item_slots_paths[i-1])
			
		if i != 9:
			item_slots_ui[i].button.set_focus_neighbor(SIDE_BOTTOM, item_slots_paths[i+1])
			item_slots_ui[i].button.set_focus_neighbor(SIDE_RIGHT, item_slots_paths[i+1])
			
	item_slots_ui[0].button.grab_focus()
