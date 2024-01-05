extends Node2D

var speed = 35

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left_pad") && $PlayerPad1/Pad.rotation > -0.6:
		var target_position = $PlayerPad1/UpPos.transform.origin
		var new_transform = $PlayerPad1/Pad.transform.looking_at(target_position)
		$PlayerPad1/Pad.transform  = $PlayerPad1/Pad.transform.interpolate_with(new_transform, speed * delta)
	elif Input.is_action_just_released("left_pad"):
		$PlayerPad1/Pad.rotation = 0
	
	if Input.is_action_pressed("right_pad") && $PlayerPad2/Pad.rotation > -0.6:
		var target_position = $PlayerPad2/UpPos.transform.origin
		var new_transform = $PlayerPad2/Pad.transform.looking_at(target_position)
		$PlayerPad2/Pad.transform  = $PlayerPad2/Pad.transform.interpolate_with(new_transform, speed * delta)
	elif Input.is_action_just_released("right_pad"):
		$PlayerPad2/Pad.rotation = 0
		

