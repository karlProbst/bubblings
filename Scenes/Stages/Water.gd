extends Area2D

# Adjustable water physics properties
@export var buoyancy_force: float = 500.0  # Upward force applied to objects
@export var drag_coefficient: float = 1.0  # Resistance applied to object motion
@export var angular_drag: float = 2.0  # Resistance to rotation

# List to track objects in the water
var bodies_in_water: Array = []

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D and body not in bodies_in_water:
		bodies_in_water.append(body)  # Add body to the list

func _on_body_exited(body: Node2D) -> void:
	bodies_in_water.erase(body)  # Remove body from the list

func _physics_process(delta: float) -> void:
	for body in bodies_in_water:
		if body is RigidBody2D:
			_apply_water_forces(body)

func _apply_water_forces(body: RigidBody2D) -> void:
	# Apply buoyancy force
	var upward_force = Vector2(0, -buoyancy_force)
	body.apply_central_force(upward_force)

	# Apply drag based on velocity
	var velocity = body.linear_velocity
	var drag_force = -velocity * drag_coefficient
	body.apply_central_force(drag_force)

	# Apply angular drag (resistance to rotation)
	var angular_velocity = body.angular_velocity
	var angular_drag_force = -angular_velocity * angular_drag
	body.apply_torque(angular_drag_force)
