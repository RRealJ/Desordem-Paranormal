extends HSlider

@export var bus_name: String

var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, value)
	match bus_index:
		0: 
			Settings.master_bus_value = value
		1:
			Settings.bgm_bus_value = value
		2:
			Settings.sfx_bus_value = value
		3: 
			Settings.sfx_weapon_bus_value = value
