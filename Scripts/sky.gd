extends Sprite2D

var bubble_scene = preload("res://Scenes/Bubble.tscn")
var growth = 0
var mouse_was_pressed=false
var StartTriggered=false
var nBubbles=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if nBubbles==1:
		$AnimationPlayer.play("new_animation_4")
		nBubbles+=1
	if StartTriggered and nBubbles==0:
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			
			if mouse_was_pressed:
				var window_size = DisplayServer.window_get_size()
				var width = window_size.x
				var height = window_size.y
				var mouse_position = get_viewport().get_mouse_position()

			
				# Instantiate the scene
				var new_bubble = create_bubble(mouse_position,growth)
				# Add the new bubble to the scene tree
				get_parent().add_child(new_bubble)
				nBubbles+=1
			mouse_was_pressed = false
			growth=0
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			mouse_was_pressed = true
			growth+=delta


func create_bubble(position: Vector2,growth:float) -> Node2D:
	# Instance the bubble scene
	var bubble_instance = bubble_scene.instantiate()
	# Set the bubble's position
	bubble_instance.position = position
	bubble_instance.scale = Vector2(0.6,0.6)
	return bubble_instance
	
	


func _on_got_button_pressed() -> void:
	$AnimationPlayer.play("new_animation_3")
	$GotButton.queue_free()


func _on_play_button_pressed() -> void:
	$AnimationPlayer.play("new_animation_2")
	$PlayButton.queue_free()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="new_animation_3":
		StartTriggered=true
		print("STARTED")
	if anim_name=="new_animation_4":
	
		get_tree().change_scene_to_file("res://Scenes/Stages/Level1.tscn")
