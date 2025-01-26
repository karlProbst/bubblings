extends RigidBody2D
var impulsetime=5
var gscale=0
var sleepbegin=5
var head:Node2D
var pin_joint
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gscale=gravity_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if head:
		if head.soltar:
			if pin_joint:
				pin_joint.queue_free()
				pin_joint=null
	if global_position.y<-2600:
		gravity_scale=2.5
	else:
		if sleepbegin>0:
			gravity_scale=1.2
			sleepbegin-=delta
		else:
			gravity_scale=gscale
	if impulsetime<=0:
		apply_central_impulse(Vector2(randf_range(-300,300),randf_range(-300,300)))
		impulsetime=randf_range(0.1,3.0)
	impulsetime-=delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("anzol"):
		body.get_parent().get_node("Head").ganchando=true
		pin_joint = PinJoint2D.new()
		global_transform.origin.x=body.global_transform.origin.x
		head=body.get_parent().get_node("Head")
		body.get_parent().get_node("Head").fishnode=self
		pin_joint.node_a = self.get_path()
		pin_joint.node_b = body.get_path()
		pin_joint.global_position = self.global_position
		get_parent().get_parent().add_child(pin_joint)
