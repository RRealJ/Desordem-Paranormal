extends CharacterBody2D
class_name Enemy

var SPEED: float = 50
var TARGET: CharacterBody2D
var DAMAGE: int = 10
var ELEMENT: elements = elements.BLOOD

enum elements {
	BLOOD,
	DEATH,
	ENERGY,
	KNOWLEDGE
}

func _process(delta: float) -> void:
	move(TARGET, delta)

func move(target, delta):
	var direction = (target.position - position).normalized()
	var desired_velocity = direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	look_at(TARGET.global_position)
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body == TARGET:
		body.recieve_damage(DAMAGE, ELEMENT)
		
		
