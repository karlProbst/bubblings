extends Sprite2D

var bubble_scene = preload("res://Scenes/Bubble.tscn")
var growth = 0.7
var mouse_was_pressed=false
var StartTriggered=false
var nBubbles=0
var trigger=0
var cooldown=0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if trigger>0:
		trigger-=delta
	if nBubbles>=100:
		for i in 10:
				var window_size2 = DisplayServer.window_get_size()
				var new_bubble = create_bubble(Vector2(randf_range(0,window_size2.x),randf_range(0,window_size2.y)),randf_range(0.2,2.0))
				# Add the new bubble to the scene tree
				get_parent().add_child(new_bubble)
		$AnimationPlayer.play("new_animation_4")
		nBubbles=-1
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		
		if trigger<=0:
			var window_size = DisplayServer.window_get_size()
			var width = window_size.x
			var height = window_size.y
			var mouse_position = get_viewport().get_mouse_position()

		
			# Instantiate the scene
			var new_bubble = create_bubble(mouse_position,growth)
			# Add the new bubble to the scene tree
			get_parent().add_child(new_bubble)
			nBubbles+=1
			trigger= cooldown
	



func create_bubble(position: Vector2,growth:float) -> Node2D:
	# Instance the bubble scene
	var bubble_instance = bubble_scene.instantiate()
	# Set the bubble's position
	bubble_instance.position = position
	bubble_instance.scale = Vector2(growth,growth)
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
