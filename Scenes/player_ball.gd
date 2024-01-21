extends RigidBody2D

var max_speed = 1800
var t
var isTeleporting = false
var AreParticlesOn = true
var IsTemporary = false
var IsTemporarySetUp = false

func _ready():
	var MainScene = get_tree().get_nodes_in_group("MainScene")
	if MainScene:
		for Main in MainScene:
			Main.SetSettings()

func _process(delta):
	if IsTemporary and !IsTemporarySetUp:
		IsTemporarySetUp = true
		$Sprite2D.texture = load("res://Art/TemporaryPlayerBall.png")
		$TemporaryLifeTimer.start()

func _integrate_forces(state):
	if !isTeleporting:
		t = state.get_transform()

	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed
	
	if isTeleporting:
		state.set_transform(t)
		isTeleporting = false

func EmitParticles(type):
	if AreParticlesOn:
		if type == "RedBall":
			$RedBallGpuParticles.emitting = true
		elif type == "RainbowBall":
			$RainbowBallGpuParticles.emitting = true
		elif type == "YellowBox":
			$YellowBoxGpuParticles.emitting = true
		elif type == "BluePortal":
			$BluePortalGpuParticles.emitting = true
		elif type == "OrangePortal":
			$OrangePortalGpuParticles.emitting = true
		elif type == "GreenBumper":
			$GreenBumperGpuParticles.emitting = true

func _on_temporary_life_timer_timeout():
	var Dispenser = get_tree().get_nodes_in_group("BallDispenser")
	if Dispenser:
		Dispenser[0].BallsInPlay -= 1
	queue_free()
