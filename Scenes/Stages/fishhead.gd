extends RigidBody2D
var impulsetime=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if impulsetime<=0:
		apply_central_impulse(Vector2(randf_range(-200,200),randf_range(-200,200)))
		impulsetime=randf_range(0.1,3.0)
		
	impulsetime-=delta
