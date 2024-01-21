extends Control

var IsScreenShakeOn = true
var IsCrazyModeOn
var AreParticlesOn = true
var AreMoreStatsOn = false

var SoundEffectVolume = 50
var MusicVolume = 50

var EffectNames = ["RedBallSound", "RainbowBallSound"]

func _ready():
	SetAudioVolume()
	IsCrazyModeOn = get_parent().get_node("GizmoScreen").IsCrazyModeOn

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_on_back_button_pressed()

func _on_sound_effect_slider_value_changed(value):
	$SoundEffectSlider/Value.text = str(value)
	SoundEffectVolume = str(value)
	SetAudioVolume()
	var rng = RandomNumberGenerator.new()
	$SoundEffectSlider.get_node(EffectNames[rng.randi_range(0, 1)]).play()

func _on_music_slider_value_changed(value):
	$MusicSlider/Value.text = str(value)
	MusicVolume = str(value)
	SetAudioVolume()

func _on_back_button_pressed():
	if visible:
		visible = false
		var mainScene = get_tree().get_first_node_in_group("MainScene")
		
		if mainScene:
			mainScene.visible = true
		else:
			get_parent().get_node("MainMenu").visible = true

func _on_screen_shake_check_box_toggled(toggled_on):
	IsScreenShakeOn = toggled_on
	UpdatedSettings()

func _on_particle_effects_check_box_toggled(toggled_on):
	AreParticlesOn = toggled_on
	UpdatedSettings()

func _on_more_stats_check_box_toggled(toggled_on):
	AreMoreStatsOn = toggled_on
	UpdatedSettings()

func SetAudioVolume():
	var Music = get_tree().get_nodes_in_group("Music")
	var SoundEffects = get_tree().get_nodes_in_group("SoundEffect")
	
	if Music:
		for track in Music:
			if float(MusicVolume) == 0:
				track.volume_db = -100
			else:
				track.volume_db = float(MusicVolume) * 0.8 - 60.0
	
	if SoundEffects:
		for soundEffect in SoundEffects:
			if float(SoundEffectVolume) == 0:
				soundEffect.volume_db = -100
			else:
				soundEffect.volume_db = float(SoundEffectVolume) * 0.8 - 45.0

func _on_secret_button_pressed():
	visible = false
	get_parent().get_node("GizmoScreen").visible = true
	
func UpdatedSettings():
	var MainScene = get_tree().get_nodes_in_group("MainScene")
	if MainScene:
		for Main in MainScene:
			Main.SetSettings()
