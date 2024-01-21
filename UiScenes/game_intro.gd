extends Control

var ShouldFadeToBlack = false
var ShouldFadeIn = false

var CountDownNumber = 3

var StingerNames = ["Stinger1", "Stinger2"]

func _process(delta):
	if ShouldFadeToBlack:
		FadeToBlack()
	if ShouldFadeIn:
		FadeIn()

func FadeToBlack():
	$FadeIn.color.a += 0.005
	get_parent().get_node("MainMenu").get_node("Music1").volume_db -= 0.5
	if $FadeIn.color.a >= 1:
		get_parent().get_node("MainMenu").visible = false
		ShouldFadeToBlack = false
		$FadePauseTimer.start()
		get_parent().get_node("MainMenu").get_node("Music1").stop()
		get_parent().get_node("GameOverScreen").visible = false

func FadeIn():
	$FadeIn.color.a -= 0.005
	if $FadeIn.color.a <= 0:
		ShouldFadeIn = false

func _on_timer_timeout():
	ShouldFadeIn = true
	var game_scene = load("res://Scenes/player_pads.tscn").instantiate()
	get_parent().add_child(game_scene)
	StartCountDown()

func StartCountDown():
	$CountDown.visible = true
	$CountDown.text = str(CountDownNumber)
	$CountDown/CountDownTimer.start()
	var rng = RandomNumberGenerator.new()
	get_node(StingerNames[rng.randi_range(0, 1)]).play()

func _on_count_down_timer_timeout():
	CountDownNumber -= 1
	
	if CountDownNumber == 0:
		$CountDown.text = "GO!"
	elif CountDownNumber > 0:
		$CountDown.text = str(CountDownNumber)
	
	if CountDownNumber >= 0:
		$CountDown/CountDownTimer.start()
	else:
		$CountDown.visible = false
		visible = false
		$FadeIn.visible = false
