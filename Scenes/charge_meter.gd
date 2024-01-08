extends Node2D

var animatedSprite

func _ready():
	animatedSprite = $Sprite

func _process(delta):
	if Input.is_action_just_pressed("charge_power"):
		animatedSprite.frame = 0
	elif Input.is_action_pressed("charge_power"):
		if animatedSprite.frame == 0:
			animatedSprite.play("Charge")
		elif animatedSprite.frame == 26:
			animatedSprite.play_backwards("Charge")
	elif Input.is_action_just_released("charge_power"):
		animatedSprite.pause()
