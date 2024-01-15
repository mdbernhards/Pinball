extends StaticBody2D

func _ready():
	pass

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	var groups = body.get_groups()
	if  groups and groups[0] == "PlayerBall":
		$HitSound.play()
		body.linear_velocity = body.linear_velocity.normalized() * 1800
		body.get_node("GPUParticles2D").emitting = true
		ShakeMath(body.linear_velocity.length())
		AddToScore()

func AddToScore():
		var ScoreArr = get_tree().get_nodes_in_group("ScoreLogic")
		ScoreArr[0].AddToCombo("GreenPad")

func ShakeMath(velocity):
	if velocity > 500 and velocity < 750:
		get_tree().call_group("Camera", "start_shake", 0.1)
	elif velocity > 750 and velocity < 1000:
		get_tree().call_group("Camera", "start_shake", 0.15)
	elif velocity > 1000 and velocity < 1250:
		get_tree().call_group("Camera", "start_shake", 0.2)
	elif velocity > 1250 and velocity < 1500:
		get_tree().call_group("Camera", "start_shake", 0.25)
	elif velocity > 1500:
		get_tree().call_group("Camera", "start_shake", 0.3)
