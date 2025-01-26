extends Node2D
# Preload the scene you want to instantiate
var bubble_scene = preload("res://Scenes/Bubble.tscn")
# The key to reset the game
var reset_key: String = "r"  # Replace "r" with the desired key
var is_muted = false
var growth = 0
var mouse_was_pressed=false
var metralha = 0
var trigger=0
var cooldown=0.1

var cherrycooldown=3

@onready var cherry = get_node("CherryRed")
# Called every frame
func _process(delta: float) -> void:
	var window_size = DisplayServer.window_get_size()
	var width = window_size.x
	var height = window_size.y

	if cherrycooldown>0:
		cherrycooldown-=delta
	else:
		cherry.global_transform.origin=Vector2(randf_range(35,520),get_node("Camera2D").position.y+height)
		cherrycooldown=30
		
		
	if metralha>0:
		metralha-=delta
		cooldown=0.091
	else:
		cooldown=999
	if trigger>0:
		trigger-=delta
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if trigger<=0:
			if mouse_was_pressed:

				var mouse_position = get_global_mouse_position()
				var new_bubble = create_bubble(mouse_position,1)
				add_child(new_bubble)
				trigger=cooldown
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		trigger=0
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mouse_was_pressed = true
		growth+=delta
	# Check for key press
	
	if Input.is_action_just_pressed("ui_select"):
		reset_scene()
	if Input.is_action_just_pressed("Mute"):
		toggle_mute()



func toggle_mute() -> void:
	is_muted = !is_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), is_muted)
# Function to reset the current scene
func reset_scene() -> void:
	get_tree().reload_current_scene()

# Function to create a bubble instance at the specified position
func create_bubble(position: Vector2,growth:float) -> Node2D:
	# Instance the bubble scene
	var bubble_instance = bubble_scene.instantiate()
	# Set the bubble's position
	bubble_instance.position = position
	bubble_instance.scale = Vector2(0.6,0.6)
	return bubble_instance


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="get2":
		get_tree().change_scene_to_file("res://Scenes/Stages/end.tscn")
