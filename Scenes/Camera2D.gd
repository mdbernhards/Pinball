extends Camera2D

@export var decay = 0.15
@export var max_offset = Vector2(40, 30)
@export var max_roll = 0.15

var trauma = 0.5
var trauma_power = 2

var isShaking = false
var IsScreenShakeOn = true

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
	if IsScreenShakeOn:
		trauma = trauma_given
		isShaking = true
		$ShakeTimer.start()

func _on_shake_timer_timeout():
	isShaking = false
	rotation = 0
	offset.x = 0
	offset.y = 0
