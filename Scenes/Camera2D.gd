extends Camera2D

@export var decay = 0.1  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(20, 15)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.2  # Maximum rotation in radians (use sparingly).

var trauma = 0.5  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

var isShaking = false

func _ready():
	randomize()
	
func _process(delta):
	if trauma and isShaking:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
	
func shake():
	var amount = pow(trauma, trauma_power)
	var rng = RandomNumberGenerator.new()
	rotation = (max_roll * amount * rng.randf_range(-1, 1))
	offset.x = (max_offset.x * amount * rng.randf_range(-1, 1))
	offset.y = (max_offset.y * amount * rng.randf_range(-1, 1))

func start_shake(trauma_given):
	trauma = trauma_given
	isShaking = true
	$ShakeTimer.start()


func _on_shake_timer_timeout():
	isShaking = false
	rotation = 0
	offset.x = 0
	offset.y = 0
