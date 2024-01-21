extends Control

var IsCrazyModeOn = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_on_back_button_pressed()

func _on_back_button_pressed():
	if visible:
		visible = false
		get_parent().get_node("SettingsMenu").visible = true

func _on_crazy_mode_check_box_toggled(toggled_on):
	IsCrazyModeOn = toggled_on
	get_parent().get_node("SettingsMenu").IsCrazyModeOn = toggled_on
	get_parent().get_node("SettingsMenu").UpdatedSettings()
