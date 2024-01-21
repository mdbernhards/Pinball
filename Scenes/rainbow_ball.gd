extends StaticBody2D

func _ready():
	pass

func _process(delta):
	$Sprite.play("rainbows")

func _on_area_2d_body_entered(body):
	if !body.get_node("Sprite"):
		var parent = get_parent()
		var parentGroups = parent.get_groups()
		if parent and parentGroups and parentGroups[0] == "RainbowShield" and parent.get_node("Timer").is_stopped():
			SetBallInPlay(body)
			$HitAnimation.play("ComboHit")
		else:
			$HitAnimation.play("Hit")
		$HitSound.play()
		if body.linear_velocity.x > 0:
			body.linear_velocity.x = body.linear_velocity.x + 100
		else:
			body.linear_velocity.x = body.linear_velocity.x - 100
		if body.linear_velocity.y > 0:
			body.linear_velocity.y = body.linear_velocity.y + 100
		else:
			body.linear_velocity.y = body.linear_velocity.y - 100
		body.EmitParticles("RainbowBall")
		ShakeMath(body.linear_velocity.length())
		AddToScore()

func AddToScore():
	var ScoreArr = get_tree().get_nodes_in_group("ScoreLogic")
	ScoreArr[0].AddToCombo("RainbowBall")

func ShakeMath(velocity):
	if velocity > 400 and velocity < 750:
		get_tree().call_group("Camera", "start_shake", 0.1)
	elif velocity > 750 and velocity < 1000:
		get_tree().call_group("Camera", "start_shake", 0.15)
	elif velocity > 1000 and velocity < 1250:
		get_tree().call_group("Camera", "start_shake", 0.3)
	elif velocity > 1250 and velocity < 1500:
		get_tree().call_group("Camera", "start_shake", 0.4)
	elif velocity > 1500:
		get_tree().call_group("Camera", "start_shake", 0.6)

func SetBallInPlay(body):
	var dispenser = get_tree().get_nodes_in_group("BallDispenser")
	dispenser[0].SetMainBallInPlay(body)
