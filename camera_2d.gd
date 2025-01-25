extends Camera2D

@onready var ball = get_node("../Ball")
var lock=false
var ballvel = 0.0

func _process(delta: float) -> void:
	# Get ball's velocity
	if !lock:
		ballvel = ball.linear_velocity.length()
		position.y = ball.position.y
		var target_zoom = clampf(ballvel / 40,1.0, 0.5)
		zoom = lerp(zoom, Vector2(target_zoom, target_zoom), delta/4)
