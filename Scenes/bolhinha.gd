extends RigidBody2D
var death=0
var deathTimerMax=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deathTimerMax=randf_range(0.0, 10.0) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	death+=delta
	if death>deathTimerMax:
		queue_free()
