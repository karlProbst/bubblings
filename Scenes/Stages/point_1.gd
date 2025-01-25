extends RigidBody2D

func _integrate_forces(state) -> void:
	# Example: Apply constant force (e.g., gravity or custom behavior)
	var constant_force = Vector2(0, 100)  # Adjust as needed
	state.apply_central_force(constant_force)

	# Handle collisions
	for i in range(state.get_contact_count()):
		var contact_position = state.get_contact_local_position(i)
		var contact_impulse = state.get_contact_impulse(i)
		# Example: React to collisions by applying opposite impulse
		state.apply_impulse(contact_position, -contact_impulse)

	# Optional: Add damping to slow down movement
