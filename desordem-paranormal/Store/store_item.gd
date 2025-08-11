extends PanelContainer


@export var store_item_data: Store_item_data
@onready var button: Button = $Button


func _ready() -> void:
	if store_item_data:
		var user_path: String = "user://Store_upgrades/".path_join(store_item_data.item_path_name)

		if FileAccess.file_exists(user_path):
			store_item_data = load(user_path) as Store_item_data
			print("Loaded weapon from user:// (saved version).")
		else:
			save_store_item()
		
		update_item_display()
		StoreUpgrades.store_upgrade_var_update(store_item_data.id, store_item_data.level)
		


func update_item_display() -> void:
	print("Store Item name and description updated and price")
	store_item_data.price = 50 + (250 * store_item_data.level)
	#store_item_data.store_item_name = get_name_from_translation()
	#store_item_data.store_item_description = get_description_from_translation()


func save_store_item() -> void:
	var user_path: String = "user://Store_upgrades/".path_join(store_item_data.item_path_name)
	print("trying to save data")
	var err := ResourceSaver.save(store_item_data, user_path)
	if err != OK:
		push_error("Failed to save store_item_resource: %s" % err)
	else:
		print("Item Store Upgrade saved at:" + "user://Store_upgrades/".path_join(store_item_data.item_path_name))
