extends Node2D

var ReloadTriangle
var ReloadTriangle_original_position
var ReloadTriangle_new_position

var PullbackDistance = 22
var Speed = 4

var BallLoaded = false
var BallsInPlay = 0
var MainBallInPlay

var IsCrazyModeOn = false
var AreMoreStatsOn = false

func _ready():
	ReloadTriangle = $ReloadTriangle
	ReloadTriangle_original_position = Vector2(ReloadTriangle.position.x, ReloadTriangle.position.y)
	ReloadTriangle_new_position = Vector2(ReloadTriangle.position.x + 5, ReloadTriangle.position.y + PullbackDistance)

func _process(delta):
	LoadNewBall(delta)
	if BallsInPlay == 0:
		BallLoaded = false
		BallsInPlay += 1

func LoadNewBall(delta):
	if !BallLoaded or (Input.is_action_pressed("load_ball") and AreMoreStatsOn):
		ReloadTriangle.position  = ReloadTriangle.position.lerp(ReloadTriangle_new_position, delta * Speed)
	else:
		ReloadTriangle.position  = ReloadTriangle.position.lerp(ReloadTriangle_original_position, delta * Speed)

func _on_area_2d_body_entered(body):
	BallLoaded = true
	MainBallInPlay = body

func SetMainBallInPlay(body):
	MainBallInPlay = body

func _on_death_zone_body_entered(body):
	body.queue_free()
	BallsInPlay -= 1

func DuplicateBall():
	if MainBallInPlay and is_instance_valid(MainBallInPlay):
		var duplicate = MainBallInPlay.duplicate()
		duplicate.IsTemporary = !IsCrazyModeOn
		add_child(duplicate)
		BallsInPlay += 1
