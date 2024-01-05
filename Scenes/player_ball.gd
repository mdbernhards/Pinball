extends RigidBody2D

var max_speed = 700

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
