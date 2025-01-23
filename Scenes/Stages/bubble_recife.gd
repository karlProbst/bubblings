extends Node2D
var bubble_scene = preload("res://Scenes/Bolhinha.tscn")
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer>0.4:
		var new_bubble = create_bubble(self.global_position,1)
	# Add the new bubble to the scene tree
		add_child(new_bubble)
		timer=0
		
	timer+=delta
func create_bubble(pos: Vector2,growth:float) -> Node2D:
	# Instance the bubble scene
	var bubble_instance = bubble_scene.instantiate()
	# Set the bubble's position
	bubble_instance.apply_central_force(Vector2(randf_range(-2000.0, 5000.0),0))
	bubble_instance.scale = Vector2(growth,growth)
	return bubble_instance
