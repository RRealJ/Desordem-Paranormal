extends Nex_upgrade

var applied: bool = false
var speed_boost: float

func apply_upgrade(_element: Weapon) -> void:
	$Buff.start(10)
	player.surto_de_adrenalina = true
	
	if !applied:
		speed_boost = player.speed * 3
		player.speed += speed_boost
		applied = true


func _on_buff_timeout() -> void:
	player.surto_de_adrenalina = false
	player.speed -= speed_boost
	$Recarga.start(30)


func _on_recarga_timeout() -> void:
	player.surto_de_adrenalina = true
	speed_boost = player.speed * 3
	player.speed += speed_boost
	$Buff.start(10)
