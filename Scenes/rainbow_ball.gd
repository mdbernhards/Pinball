extends StaticBody2D

func _ready():
	pass

func _process(delta):
	$Sprite.play("rainbows")

func _on_area_2d_body_entered(body):
	if !body.get_node("Sprite"):
		$HitAnimation.play("Hit")
		$HitSound.play()
