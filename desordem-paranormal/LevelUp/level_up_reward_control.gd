extends Control

@onready var inventory_control := $"../../Inventory_Ui/inventory_control"
@onready var slot_1: Panel = $Panel
@onready var slot_2: Panel = $Panel2
@onready var slot_3: Panel = $Panel3
var current_items_nexes: Array[Resource]
var erasing: bool

func _ready() -> void:
	get_array_of_items()


func get_array_of_items() -> void:
	var shuffled: Array[Dictionary] = Global.items_resources_avaible.duplicate(true)
	shuffled.shuffle()
	
	var items_got: Array[Dictionary] = shuffled.slice(0, 3)
	
	for i in range(3):
		current_items_nexes.append(items_got[i].values()[0])
	
	insert_items_into_slots()
	

func insert_items_into_slots() -> void:
	slot_1.item = current_items_nexes[0]
	slot_2.item = current_items_nexes[1]
	slot_3.item = current_items_nexes[2]
	slot_1.update_slot()
	slot_2.update_slot()
	slot_3.update_slot()

	
func seleted_item(item: Resource) -> void:
	if erasing:
		if Global.items_resources_avaible.has({item.id: item}):
			Global.items_resources_avaible.erase({item.id: item})
			if current_items_nexes[0] == item:
				slot_1.item_deleted()
			elif current_items_nexes[1] == item:
				slot_2.item_deleted()
			elif current_items_nexes[2] == item:
				slot_3.item_deleted()				
			print(Global.items_resources_avaible)
			
			erasing = false
	else:	
		item.level += 1
		inventory_control.insert_item(item)
	
	
func _on_reroll_pressed() -> void:
	get_array_of_items()
	
	
func _on_erase_pressed() -> void:
	erasing = true
	
	
#fazer a tela pegar as informações dos items da Global.items_avaible
#irá ser verificado o se o item está nivel maximo
#caso estiver ele é retirado do Global.items_avaible

#Ai passar as informações
#Quando o jogador escolher, irá passar o ID do item pro Inventario.insert_item(item_id)
#Quando o jogador "excluir", uma opção de item ele irá ser retirado do Global.items_avaible
