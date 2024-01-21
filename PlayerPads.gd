extends Node2D

var upSpeed = 17.5
var downSpeed = 4.0

var curvyWall
var curvyWall_original_position
var curvyWall_new_position
var closedDistance = -90
var curvyWallSpeed = 20

var GameOver = false

func _ready():
	curvyWall = $Environment/RightWall/CornerWall
	curvyWall_original_position = Vector2(curvyWall.position.x, curvyWall.position.y)
	curvyWall_new_position = Vector2(curvyWall.position.x + closedDistance, curvyWall.position.y)
	SetSettings()

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
	GetFastestSpeed()
	CheckIfGameOver()

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

func GetFastestSpeed():
	var PlayerBalls = get_tree().get_nodes_in_group("PlayerBall")
	var MaxSpeed = 0
	
	for playerBall in PlayerBalls:
		if MaxSpeed < playerBall.linear_velocity.length():
			MaxSpeed = playerBall.linear_velocity.length()
	
	$SpeedLabel.text = "Speed: " + str(snapped(MaxSpeed, 20))

func SetSettings():
	var Cameras = get_tree().get_nodes_in_group("Camera")
	var Settings = get_tree().get_nodes_in_group("Settings")
	var PlayerBalls = get_tree().get_nodes_in_group("PlayerBall")
	var RedStars = get_tree().get_nodes_in_group("RedStar")
	var RainbowShields = get_tree().get_nodes_in_group("RainbowShield")
	var Dispenser = get_tree().get_nodes_in_group("BallDispenser")
	var GameOverScreen = get_tree().get_first_node_in_group("GameOver")
	
	if Settings:
		if Cameras:
			Cameras[0].IsScreenShakeOn = Settings[0].IsScreenShakeOn
		
		if PlayerBalls:
			for playerBall in PlayerBalls:
				playerBall.AreParticlesOn = Settings[0].AreParticlesOn
		
		if RedStars:
			for RedStar in RedStars:
				RedStar.AreParticlesOn = Settings[0].AreParticlesOn
		
		if RainbowShields:
			for RainbowShield in RainbowShields:
				RainbowShield.AreParticlesOn = Settings[0].AreParticlesOn
				if Settings[0].IsCrazyModeOn:
					RainbowShield.BallsNeededForCombo = 2
				else:
					RainbowShield.BallsNeededForCombo = 4
		
		if GameOverScreen:
			GameOverScreen.IsCrazyModeOn = Settings[0].IsCrazyModeOn
		
		if Dispenser:
			Dispenser[0].IsCrazyModeOn = Settings[0].IsCrazyModeOn
			Dispenser[0].AreMoreStatsOn = Settings[0].AreMoreStatsOn
		
		$SpeedLabel.visible = Settings[0].AreMoreStatsOn
		$HighScoreLogic/ComboLabel/Timer/Label.visible = Settings[0].AreMoreStatsOn
		Settings[0].SetAudioVolume()

func CheckIfGameOver():
	var lastPlayerBall = get_tree().get_first_node_in_group("PlayerBall")
	
	if !lastPlayerBall and !GameOver:
		$GameOverTimer.start()
		GameOver = true

func _on_game_over_timer_timeout():
	var GameOverScreen = get_tree().get_first_node_in_group("GameOver")
	GameOverScreen.ShowGameOver($HighScoreLogic.Score)
