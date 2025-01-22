extends RigidBody2D

# Define the gravity or bounce force (adjust this to suit your needs)
var bounce_force: float = 50000
var gravity: Vector2 = Vector2(0, 500)  # Example gravity force

# Called when the node enters the scene tree for the first time.

# Called when a body enters this RigidBody2D's collision area.
func _on_body_entered(body: Node) -> void:

	# Check if the body that entered is a bubble
	if body.is_in_group("bubble"):
		# Apply a bounce force or gravity to the bubble (depending on your need)
		var direction = (body.position - position).normalized()  # Direction away from character
		body.apply_central_impulse(direction * bounce_force)  # Apply bounce force in the direction
		print("YAAAAAAAAAAAAAAAA")
