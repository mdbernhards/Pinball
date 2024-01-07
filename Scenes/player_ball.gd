extends RigidBody2D

var max_speed = 2000

func _ready():
	pass

func _process(delta):
	pass

func _integrate_forces(state):
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed

	if Input.is_action_pressed("reset"):
		var t = state.get_transform()

		t.origin.x = get_parent().get_node("Marker2D").position.x
		t.origin.y = get_parent().get_node("Marker2D").position.y
		state.set_transform(t)


func _on_body_entered(body):
	if body.get_node("HitAnimation"):
		body.get_node("HitAnimation").play("Hit")


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.get_node("HitAnimation"):
		body.get_node("HitAnimation").play("Hit")
