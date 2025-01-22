extends Area2D

# Adjust these variables to control the water behavior
@export var buoyancy_force: float = 200.0
@export var drag_coefficient: float = 0.1

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		body.custom_integrator = true  # Enable custom integration to manually apply forces

func _on_body_exited(body: Node2D) -> void:
	if body is RigidBody2D:
		body.custom_integrator = false

func _integrate_forces(body, state) -> void:
	# Get the body's position and velocity
	var position = body.global_position
	var velocity = body.linear_velocity

	# Apply upward buoyancy force
	var upward_force = Vector2(0, -buoyancy_force)
	body.add_central_force(upward_force)

	# Apply drag force based on velocity
	var drag_force = -velocity * drag_coefficient
	body.add_central_force(drag_force)
