extends Nex_upgrade

var applied: bool = false

func apply_upgrade(_element: Weapon) -> void:
	if !applied:
		player.inquebravel = true
		applied = true	
	
func _on_recarga_timeout() -> void:
	player.inquebravel = true
