extends Node

# The key to reset the game
var reset_key: String = "r"  # Replace "r" with the desired key

# Called every frame
func _process(delta: float) -> void:
	# Check for key press
	if Input.is_action_just_pressed("ui_select"):
		reset_scene()

# Function to reset the current scene
func reset_scene() -> void:
	get_tree().reload_current_scene()
