extends AnimatableBody2D

var startY = position.y
var chargeSpeed = 2.1
var shootSpeed = 25.4
var pullBackDistance = 130
var target_position
var new_transform

func _ready():
	target_position = Vector2(position.x, position.y)
	new_transform = Vector2(position.x, position.y + pullBackDistance)

func _process(delta):
	if Input.is_action_pressed("charge_power") && startY + 428 > position.y:
		position  = position.lerp(new_transform, delta * chargeSpeed)
		if !$HitSound.playing:
			$HitSound.play()
	elif Input.is_action_pressed("charge_power"):
		pass
	else:
		$HitSound.stop()
		var charge = get_parent().get_node("ChargeMeter").get_node("Sprite").frame
		charge = charge/2 + 3
		position  = position.lerp(target_position, delta * charge)
