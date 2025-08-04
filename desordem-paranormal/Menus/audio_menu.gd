extends Control

@onready var sliders: Array[HSlider] = [
	$Sliders/Master,
	$Sliders/BGM,
	$Sliders/SFX,
	$Sliders/Weapon_SFX
]

@onready var labels: Array[Node] = $Labels.get_children()
var go_back_to_button: Button

func _ready() -> void:
	for slider in sliders:
		slider.focus_entered.connect(change_label_color.bind(slider, true))
		slider.focus_exited.connect(change_label_color.bind(slider, false))		
	$Sliders/Master.grab_focus()
	
	go_back_to_button = $"../..".button_audio
	
	
		
func change_label_color(slider: HSlider, entering_focus: bool) -> void:
	for i in range(sliders.size()):
		
		if slider == sliders[i]:
			
			if entering_focus:
				labels[i].modulate = Color(0.93, 0.71, 0.0, 1)
				break
			else:
				labels[i].modulate = Color(1, 1, 1, 1)
				break
	

func update_audio_value() -> void:
	$Sliders/Master.value = Settings.master_bus_value
	$Sliders/BGM.value = Settings.bgm_bus_value
	$Sliders/SFX.value = Settings.sfx_bus_value
	$Sliders/Weapon_SFX.value = Settings.sfx_weapon_bus_value
	
