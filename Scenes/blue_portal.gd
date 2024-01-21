extends StaticBody2D

func _on_teleport_area_body_entered(body):
	var groups = body.get_groups()
	if  groups and groups[0] == "PlayerBall":
		body.t.origin.x = body.t.origin.x - 1035
		body.isTeleporting = true
		ShakeMath(body.linear_velocity.length())
		body.EmitParticles("BluePortal")
		$HitSound.play()
		AddToScore()

func AddToScore():
	var ScoreArr = get_tree().get_nodes_in_group("ScoreLogic")
	ScoreArr[0].AddToCombo("Portal")

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
