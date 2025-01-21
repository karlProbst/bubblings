extends Area2D

# Number of points on the bubble's boundary
const POINT_COUNT = 16
const RADIUS = 50
var points = []

# Called when the node enters the scene tree
func _ready():
	for i in range(POINT_COUNT):
		var angle = i * TAU / POINT_COUNT
		var point = create_point(Vector2(cos(angle), sin(angle)) * RADIUS)
		points.append(point)
		
	for i in range(POINT_COUNT):
		var joint = PinJoint2D.new()
		joint.node_a = points[i].get_path()  # Get the full NodePath of the current point
		joint.node_b = points[(i + 1) % POINT_COUNT].get_path()  # Get the full NodePath of the next point
		add_child(joint)
	
	# Update visuals
	var polygon = $Polygon2D
	polygon.polygon = calculate_polygon()
	
func create_point(position: Vector2) -> RigidBody2D:
	var point = RigidBody2D.new()
	point.position = position

	# Add CollisionShape2D
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = CircleShape2D.new()
	collision_shape.shape.radius = 5  # Adjust size as needed
	point.add_child(collision_shape)

	add_child(point)
	return point

func calculate_polygon() -> PackedVector2Array:
	var vertices = PackedVector2Array()
	for point in points:
		vertices.append(point.position)
	return vertices
	
# Called every frame
func _process(delta):
	$Polygon2D.polygon = calculate_polygon()
