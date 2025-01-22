extends Area2D
@export var pombo: Node2D

@export var force: Vector2 = Vector2(0,-110)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		body.linear_velocity = Vector2.ZERO  # Stops linear movement
		body.angular_velocity = 0  # Stops angular rotation
		pombo.get_node("Gluglu").play()
		body.apply_central_impulse(force)
		pombo.play()
		
