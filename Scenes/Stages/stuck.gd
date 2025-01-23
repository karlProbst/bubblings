extends Area2D
# List to keep track of bodies currently in the area
var bodies_in_area = []

@export var force: Vector2 = Vector2(0, -0.1)  # Adjust the force as needed

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and body not in bodies_in_area:
		bodies_in_area.append(body)  # Add body to the list


func _on_body_exited(body: Node2D) -> void:
	bodies_in_area.erase(body)  # Remove body from the list


func _physics_process(delta: float) -> void:

	# Continuously apply forces to bodies in the area
	for body in bodies_in_area:
		if body.is_in_group("ball"):
			body.linear_velocity = Vector2.ZERO  # Stops linear movement
			body.angular_velocity = 0  # Stops angular rotation
			get_parent().get_node("PomboDaPraca/AnimationPlayer").play("get")
		if body:
			body.apply_central_impulse(force)
