extends Node

var MusicNames = ["Music1", "Music2", "Music3"]
var MusicPlaying = "Music3"

func _ready():
	$Timer.start()

func _process(delta):
	if $Timer.is_stopped() and !$Music1.playing and !$Music2.playing and !$Music3.playing:
		PlayMusic()

func PlayMusic():
	var rng = RandomNumberGenerator.new()
	var musicToBePlayed = MusicNames[rng.randi_range(0, 2)]
	if musicToBePlayed != MusicPlaying:
		MusicPlaying = musicToBePlayed
		get_node(MusicPlaying).play()

func _on_music_3_finished():
	$Timer.start()

func _on_music_1_finished():
	$Timer.start()

func _on_music_2_finished():
	$Timer.start()
