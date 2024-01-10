extends StaticBody2D

@export var rotateClockwise = true

func _ready():
	pass

func _process(delta):
	if rotateClockwise:
		rotation = rotation + 0.02
	else:
		rotation = rotation - 0.02
