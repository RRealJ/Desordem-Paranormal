extends Area2D

@onready var player: CharacterBody2D = $".."
@onready var tween: Tween = get_tree().create_tween()


func _on_area_entered(area: Area2D) -> void:
	tween = get_tree().create_tween()
	tween.tween_property(area, "global_position", self.global_position, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_absorv_delete_area_entered(area: Area2D) -> void:
	if area.is_in_group("Money"):
		player.money += area.money_value
		
	elif area.is_in_group("Exp"):
		player.exp += area.exp_value
		player.nex += area.nex_value
	area.queue_free()
