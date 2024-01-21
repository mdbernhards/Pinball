extends StaticBody2D

func _on_area_2d_body_entered(body):
	var groups = body.get_groups()
	if groups and groups[0] == "PlayerBall":
		var parent = get_parent()
		var parentGroups = parent.get_groups()
		if parent and parentGroups and parentGroups[0] == "RedStar" and parent.get_node("Timer").is_stopped():
			$Sprite.play("ComboHit")
		else:
			$Sprite.play("Hit")
		$HitSound.play()
		body.linear_velocity = body.linear_velocity * 3
		if body.linear_velocity.x > 0:
			body.linear_velocity.x = body.linear_velocity.x + 100
		else:
			body.linear_velocity.x = body.linear_velocity.x - 100
		if body.linear_velocity.y > 0:
			body.linear_velocity.y = body.linear_velocity.y + 100
		else:
			body.linear_velocity.y = body.linear_velocity.y - 100
		body.EmitParticles("RedBall")
		ShakeMath(body.linear_velocity.length())
		AddToScore()

func AddToScore():
		var ScoreArr = get_tree().get_nodes_in_group("ScoreLogic")
		ScoreArr[0].AddToCombo("RedBall")

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
