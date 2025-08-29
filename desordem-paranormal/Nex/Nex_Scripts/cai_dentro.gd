extends Nex_upgrade

var applied: bool = false

func apply_upgrade(_element: Weapon) -> void:
	if !applied:
		player.resistence += 50.0
		applied = true
		player.cai_dentro = true
		$persist.start(15)


func _on_timer_timeout() -> void:
	player.cai_dentro = true
	$persist.start(15)
	

func _on_persist_timeout() -> void:
	player.cai_dentro = false
	$cooldown.start(30)
