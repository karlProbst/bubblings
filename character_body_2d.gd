extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 15
var accel_gravity = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		accel_gravity+=GRAVITY
	else:
		accel_gravity=0


	velocity.x = 1 * SPEED
	velocity.y=accel_gravity

	move_and_slide()
	
