extends AnimatedSprite2D

var AreParticlesOn = true

func _process(delta):
	CheckIfCombo()
	
	if !$Timer.is_stopped():
		play("Combo")
		if AreParticlesOn:
			$RedBallGpuParticles.emitting = true

func CheckIfCombo():
	var ballsActive = 0
	
	for object in get_children():
		var objectGroups = object.get_groups()
		if objectGroups and objectGroups[0] == "ComboBall":
			if object.get_node("Sprite").animation == "ComboHit" and (object.get_node("Sprite").get_frame() == 1 or object.get_node("Sprite").get_frame() == 2 or object.get_node("Sprite").get_frame() == 3 or object.get_node("Sprite").get_frame() == 4):
				ballsActive += 1
	
	if ballsActive == 4 and $Timer.is_stopped():
		Combo()
		AddToScore()

func AddToScore():
	var ScoreArr = get_tree().get_nodes_in_group("ScoreLogic")
	ScoreArr[0].AddToCombo("RedBallCombo")

func Combo():
	$Timer.start()
	$HitSound.play()
