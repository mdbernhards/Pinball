extends Node

func _ready():
	load_main_menu()

func load_main_menu():
	$MainMenu/PlayButton.connect("pressed", Callable(self, "on_play_pressed"))
	$MainMenu/SettingsButton.connect("pressed", Callable(self, "on_settings_pressed"))
	$MainMenu/QuitButton.connect("pressed", Callable(self, "on_quit_pressed"))

func on_settings_pressed():
	$MainMenu.visible = false
	$SettingsMenu.visible = true

func on_play_pressed():
	$GameIntro.visible = true
	$GameIntro/FadeIn.visible = true
	$GameIntro.ShouldFadeToBlack = true
	$GameIntro.CountDownNumber = 3

func on_quit_pressed():
	get_tree().quit()
