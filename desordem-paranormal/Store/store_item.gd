extends PanelContainer


@export var store_item_data: Store_item_data
@onready var button: Button = $Button


func update_item_display() -> void:
	print("Store Item name and description updated")
	store_item_data.price = 50 + (250 * store_item_data.level)
	#store_item_data.store_item_name = get_name_from_translation()
	#store_item_data.store_item_description = get_description_from_translation()
	
