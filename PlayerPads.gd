extends Node2D

var upSpeed = 17.5
var downSpeed = 4.0

var curvyWall
var curvyWall_original_position
var curvyWall_new_position
var closedDistance = -90
var curvyWallSpeed = 20

func _ready():
	curvyWall = $Environment/RightWall/CornerWall
	curvyWall_original_position = Vector2(curvyWall.position.x, curvyWall.position.y)
	curvyWall_new_position = Vector2(curvyWall.position.x + closedDistance, curvyWall.position.y)

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
		
	moveCurvyWallWhenShoot(delta)
	
	$SpeedLabel.text = "Speed: " + str(snapped($PlayerBall.linear_velocity.length(), 50))

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

func moveCurvyWallWhenShoot(delta):
	if Input.is_action_pressed("charge_power"):
		curvyWall.position  = curvyWall.position.lerp(curvyWall_new_position, delta * curvyWallSpeed)
	elif Input.is_action_just_released("charge_power"):
		curvyWall.get_node("Timer").start()
	elif curvyWall.get_node("Timer").is_stopped():
		curvyWall.position  = curvyWall.position.lerp(curvyWall_original_position, delta * curvyWallSpeed)
