extends RigidBody2D

var max_speed = 1800
var t
var isTeleporting = false

func _ready():
	pass

func _process(delta):
	pass

func _integrate_forces(state):
	if !isTeleporting:
		t = state.get_transform()
	
	if state.linear_velocity.length() > max_speed:
		state.linear_velocity = state.linear_velocity.normalized() * max_speed

	if Input.is_action_pressed("reset"):
		t.origin.x = get_parent().get_node("Marker2D").position.x
		t.origin.y = get_parent().get_node("Marker2D").position.y
		state.set_transform(t)
		
	if Input.is_action_pressed("teleportLeft"):
		t.origin.x = get_parent().get_node("Marker2D2").global_position.x
		t.origin.y = get_parent().get_node("Marker2D2").global_position.y
		state.linear_velocity = state.linear_velocity.normalized() * 1300
		state.set_transform(t)
		
	if Input.is_action_pressed("teleportRight"):
		t.origin.x = get_parent().get_node("Marker2D3").global_position.x
		t.origin.y = get_parent().get_node("Marker2D3").global_position.y
		state.linear_velocity = state.linear_velocity.normalized() * 1300
		state.set_transform(t)
		
	if isTeleporting:
		state.set_transform(t)
		isTeleporting = false
