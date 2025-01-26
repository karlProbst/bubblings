extends RigidBody2D
@onready var ball = get_parent().get_node("Ball")
var gscale=0
var dist=Vector2(0,0)
var grabbed=false
var dietime=1
func _ready() -> void:
	gscale=gravity_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dist = position.distance_to(ball.position)

	if dist<90 and !grabbed:
		get_parent().metralha=10
		$AnimationPlayer.play("grabbed")
		grabbed=true
	if grabbed:
		set_collision_layer_value(1,false)
		dietime-=delta
		if dietime<=0:
			global_transform.origin.x=10000
			get_parent().cherrycooldown=30
			resurrect()
	if gravity_scale>gscale:
		gravity_scale-=delta*2
	else:
		set_collision_layer_value(1,false)

func resurrect():
	set_collision_layer_value(1,false)
	$AnimationPlayer.play("new_animation")
	dietime=1
	grabbed=false
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("bubble"):
		set_collision_layer_value(1,true)
		gravity_scale=0.4
		apply_central_force(Vector2(0,10))
		
