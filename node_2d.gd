extends Node
# Preload the scene you want to instantiate
var bubble_scene = preload("res://Scenes/Bubble.tscn")
# The key to reset the game
var reset_key: String = "r"  # Replace "r" with the desired key

var growth = 0
var mouse_was_pressed=false
# Called every frame
func _process(delta: float) -> void:
	
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		
		if mouse_was_pressed:
			var mouse_position = get_viewport().get_mouse_position()
		
			# Instantiate the scene
			var new_bubble = create_bubble(mouse_position,growth)
			# Add the new bubble to the scene tree
			add_child(new_bubble)
		mouse_was_pressed = false
		growth=0
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_was_pressed = true
		growth+=delta
	# Check for key press
	
	if Input.is_action_just_pressed("ui_select"):
		reset_scene()

# Function to reset the current scene
func reset_scene() -> void:
	get_tree().reload_current_scene()

# Function to create a bubble instance at the specified position
func create_bubble(position: Vector2,growth:float) -> Node2D:
	# Instance the bubble scene
	var bubble_instance = bubble_scene.instantiate()
	# Set the bubble's position
	bubble_instance.position = position
	bubble_instance.scale = Vector2(1,1)
	return bubble_instance