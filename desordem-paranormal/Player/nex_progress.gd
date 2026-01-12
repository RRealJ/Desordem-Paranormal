extends TextureProgressBar


@onready var char: Player
@onready var current_nex_goal: int = 0
const NEX_PROGRESSION : Array[float] = [5.0, 10.0, 40.0, 65.0, 75.0, 99.0]
var nex_done : bool = false


func _ready() -> void:
	char = Global.player
	char.nexChange.connect(update)
	char.nexUp.connect(change_nex_max_value)
	max_value = NEX_PROGRESSION[current_nex_goal]
	value = 0.0


func change_nex_max_value() -> void:
	if max_value != 99.0:
		current_nex_goal += 1
		max_value = NEX_PROGRESSION[current_nex_goal]	
		
	else:
		nex_done = true
		
func update() -> void:
	if !nex_done:
		value = char.nex
		print("nex: ", value)
		
		if value == max_value:
			char.emit_signal("nexUp")
			
			
		
			
	
