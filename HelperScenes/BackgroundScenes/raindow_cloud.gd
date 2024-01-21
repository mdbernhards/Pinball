extends Sprite2D

var AreParticlesOn = true
var BallsNeededForCombo = 2

func _process(delta):
	CheckIfCombo()
	
	if !$Timer.is_stopped():
		rotation += 0.015
		if AreParticlesOn:
			$RainbowBallGpuParticles.emitting = true
	else:
		rotation += 0.005

func CheckIfCombo():
	var ballsActive = 0
	
	for object in get_children():
		var objectGroups = object.get_groups()
		if objectGroups and objectGroups[0] == "RainbowComboBall":
			if object.get_node("HitAnimation").animation == "ComboHit" and (object.get_node("HitAnimation").get_frame() == 1 or object.get_node("HitAnimation").get_frame() == 2 or object.get_node("HitAnimation").get_frame() == 3 or object.get_node("HitAnimation").get_frame() == 4):
				ballsActive += 1
	
	if ballsActive == BallsNeededForCombo and $Timer.is_stopped():
		Combo()
		AddToScore()

func AddToScore():
		var ScoreArr = get_tree().get_nodes_in_group("ScoreLogic")
		ScoreArr[0].AddToCombo("RainbowBallCombo")

func Combo():
	$Timer.start()
	$SlowmotionTimer.start()
	Engine.time_scale = 0.25
	$HitSound.play()
	var dispenser = get_tree().get_nodes_in_group("BallDispenser")
	dispenser[0].DuplicateBall()

func _on_slowmotion_timer_timeout():
	Engine.time_scale = 1
