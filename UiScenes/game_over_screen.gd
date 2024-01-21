extends Control

var ShouldFadeToBlack = false
var IsCrazyModeOn = false

func _ready():
	$ColorRect/MainMenuButton.visible = false
	$ColorRect/PlayAgainButton.visible = false
	$ColorRect/QuitButton.visible = false

func _process(delta):
	if ShouldFadeToBlack:
		FadeToBlack()

func FadeToBlack():
	$ColorRect.color.a += 0.005
	#get_parent().get_node("MainMenu").get_node("Music1").volume_db -= 0.5
	if $ColorRect.color.a >= 1:
		StopGame()
		ShouldFadeToBlack = false
		$ColorRect/MainMenuButton.visible = true
		$ColorRect/PlayAgainButton.visible = true
		$ColorRect/QuitButton.visible = true

func ShowGameOver(finalScore):
	visible = true
	ShouldFadeToBlack = true
	if finalScore:
		$ColorRect/TotalScoreValueLabel.text = str(finalScore)
		$ColorRect/CrazyLabel.visible = IsCrazyModeOn

func _on_main_menu_button_pressed():
	StopGame()
	visible = false
	get_parent().get_node("MainMenu").visible = true
	get_parent().get_node("MainMenu").get_node("Music1").play()

func _on_play_again_button_pressed():
	StopGame()
	get_parent().on_play_pressed()

func _on_quit_button_pressed():
	get_tree().quit()

func StopGame():
	var MainScene = get_tree().get_nodes_in_group("MainScene")
	if MainScene:
		for Main in MainScene:
			Main.queue_free()
