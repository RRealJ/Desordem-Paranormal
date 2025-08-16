extends PanelContainer


@export var store_item_data: Store_item_data
@onready var button: Button = $Button
@onready var level_bar: ProgressBar = $ProgressBar


func _ready() -> void:
	if store_item_data:
		var user_path: String = "user://Store_upgrades/".path_join(store_item_data.item_path_name)

		if FileAccess.file_exists(user_path):
			store_item_data = load(user_path) as Store_item_data
		else:
			save_store_item()
		
		update_item_display()
		StoreUpgrades.store_upgrade_var_update(store_item_data.id, store_item_data.level)
		
		
func update_item_display() -> void:
	store_item_data.price = 50 + (250 * store_item_data.level)
	print(store_item_data.level)
	
	if store_item_data.level < 5:
		store_item_data.price *= 1.5
	elif store_item_data.level == 5:
		store_item_data.price = 4444
	elif store_item_data.level == 6:
		store_item_data.price = 6900
		

	level_bar.value = store_item_data.level
	if level_bar.value == level_bar.max_value:
		level_bar.modulate = Color(0.69, 0, 0.9, 1)

	#store_item_data.store_item_name = get_name_from_translation()
	#store_item_data.store_item_description = get_description_from_translation()


func save_store_item() -> void:
	var user_path: String = "user://Store_upgrades/".path_join(store_item_data.item_path_name)
	var err := ResourceSaver.save(store_item_data, user_path)
	if err != OK:
		push_error("Failed to save store_item_resource: %s" % err)
	else:
		print("Item Store Upgrade saved at:" + "user://Store_upgrades/".path_join(store_item_data.item_path_name))
