extends AnimatableBody2D

var startY = position.y
var chargeSpeed = 2.1
var shootSpeed = 25.4
var pullBackDistance = 150
var target_position
var new_transform

func _ready():
	target_position = Vector2(position.x, position.y)
	new_transform = Vector2(position.x, position.y + pullBackDistance)

func _process(delta):
	if Input.is_action_pressed("charge_power") && startY + 400 > position.y:
		position  = position.lerp(new_transform, delta * chargeSpeed)
	elif Input.is_action_pressed("charge_power"):
		pass
	else:
		position  = position.lerp(target_position, delta * shootSpeed)
