extends StaticBody2D

func _ready():
	pass

func _process(delta):
	pass

func _on_teleport_area_body_entered(body):
	var groups = body.get_groups()
	if  groups and groups[0] == "PlayerBall":
		body.t.origin.x = body.t.origin.x - 1035
		body.isTeleporting = true
