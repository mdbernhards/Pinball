extends Node2D

var upSpeed = 30.0
var downSpeed = 10.0

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("left_pad"):
		if $PlayerPad1/Pad.rotation > -0.6:
			calculatePadSwing($PlayerPad1, delta, true)
	else:
		calculatePadSwing($PlayerPad1, delta, false)

	if Input.is_action_pressed("right_pad"):
		if $PlayerPad2/Pad.rotation > -0.6:
			calculatePadSwing($PlayerPad2, delta, true)
	else:
		calculatePadSwing($PlayerPad2, delta, false)

func calculatePadSwing(node, delta, isGoingUp):
	var target_position
	var new_speed

	if isGoingUp:
		target_position = node.get_node("UpPos").transform.origin
		new_speed = upSpeed * delta
	else:
		target_position = node.get_node("DownPos").transform.origin
		new_speed = downSpeed * delta

	var new_transform = node.get_node("Pad").transform.looking_at(target_position)
	node.get_node("Pad").transform  = node.get_node("Pad").transform.interpolate_with(new_transform, new_speed)
