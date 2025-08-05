extends Control

@onready var resolution_options: OptionButton = $VBoxContainer2/resolution
@onready var buttons: Array[Node] = $VBoxContainer2.get_children()
@onready var labels: Array[Node] = $VBoxContainer.get_children()

const RESOLUTIONS: Dictionary = {
	"320x180": Vector2i(320,180),
	"640x360": Vector2i(640,360),
	"800x600": Vector2i(800,600),
	"1024x600": Vector2i(1024,600),
	"1280x720": Vector2i(1280,720),
	"1366x768": Vector2i(1366,768),
	"1440x900": Vector2i(1440,900),
	"1600x900": Vector2i(1600,900),
	"1920x1080": Vector2i(1920,1080),
	"2560x1080": Vector2i(2560,1080),
	"2560x1440": Vector2i(2560,1440),
	"3840x2160": Vector2i(3840,2160),
}

var go_back_to_button: Button
var index_focus_button: int

func _ready() -> void:
	for resolution: String in RESOLUTIONS.keys():
		resolution_options.add_item(resolution)
		
	for button in buttons:
		button.focus_entered.connect(change_label_color.bind(button, true))
		button.focus_exited.connect(change_label_color.bind(button, false))
	
	go_back_to_button = $"../..".button_video

func _on_resolution_item_selected(index: int) -> void:
	var key: String = resolution_options.get_item_text(index)
	get_window().set_size(RESOLUTIONS[key])
	Settings.center_window()
	
	
func change_label_color(button: Button, entering_focus: bool) -> void:
	for i in range(buttons.size()):
		
		if button == buttons[i]:
			
			if entering_focus:
				labels[i].modulate = Color(0.93, 0.71, 0.0, 1)
				index_focus_button = i
				break
			else:
				labels[i].modulate = Color(1, 1, 1, 1)
				break


func update_buttons_value() -> void:
	resolution_options.selected = Settings.resolution_screen_index
	$VBoxContainer2/Vsync.toggled = Settings.isVsyncOn
	$VBoxContainer2/fullscreen.toggles = Settings.isFullscreen
	

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_toggled(toggled_on: bool) -> void:
	get_window().borderless = toggled_on


func _on_vsync_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		

	
