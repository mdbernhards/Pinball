extends StaticBody2D

@export var rotateClockwise = true

func _ready():
	pass

func _process(delta):
	if rotateClockwise:
		rotation = rotation + 0.02
	else:
		rotation = rotation - 0.02

func _on_area_2d_body_entered(body):
	var groups = body.get_groups()
	if groups and groups[0] == "PlayerBall":
		ShakeMath(body.linear_velocity.length())
		AddToScore()

func AddToScore():
		var ScoreArr = get_tree().get_nodes_in_group("ScoreLogic")
		ScoreArr[0].AddToCombo("YellowBox")

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
