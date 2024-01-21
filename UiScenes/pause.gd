extends Control

func _ready():
	$ColorRect.visible = true

func _process(delta):
	CheckIfPause()

func _on_back_button_pressed():
	visible = false
	get_tree().paused = false
	get_parent().get_node("HighScoreLogic").get_node("ComboSumLabel").visible = true

func _on_main_menu_button_pressed():
	get_parent().get_parent().get_node("MainMenu").visible = true
	get_parent().get_parent().get_node("MainMenu").get_node("Music1").play()
	visible = false
	get_tree().paused = false
	StopGame()

func _on_settings_button_pressed():
	get_parent().visible = false
	get_parent().get_node("HighScoreLogic").get_node("ComboSumLabel").visible = false
	get_parent().get_parent().get_node("SettingsMenu").visible = true

func StopGame():
	var MainScene = get_tree().get_nodes_in_group("MainScene")
	if MainScene:
		for Main in MainScene:
			Main.queue_free()

func CheckIfPause():
	if Input.is_action_just_pressed("pause"):
		get_parent().get_node("HighScoreLogic").get_node("ComboSumLabel").visible = true
		PauseGame()
		visible = !visible

func PauseGame():
	if get_tree().is_paused():
		get_tree().paused = false
	else:
		get_tree().paused = true
