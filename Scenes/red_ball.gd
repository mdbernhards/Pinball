extends StaticBody2D

func _ready():
	pass

func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	var groups = body.get_groups()
	if  groups and groups[0] == "PlayerBall":
		$Sprite.play("Hit")
		$HitSound.play()
		body.linear_velocity = body.linear_velocity.normalized() * 1300
		$GPUParticles2D.position.x = clamp(position.x, -140, 140)
		$GPUParticles2D.position.y = clamp(position.y, -140, 140)
		body.get_node("GPUParticles2D").emitting = true
