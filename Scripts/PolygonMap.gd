extends Node2D



# Reference to the Polygon2D node
var polygon: Polygon2D
var SHADER = preload("res://Shaders/BubbleShader.gdshader")
# Scaling factor for enlarging the polygon
var scale_factor: float = 1.5

# Called when the node enters the scene tree
func _ready():
	# Create the Polygon2D node
	polygon = Polygon2D.new()
	add_child(polygon)
	
	# Assign a material to the polygon
	var material = ShaderMaterial.new()
	material.shader = Shader.new()
	material.shader = SHADER
	polygon.material = material

# Called every frame
func _process(delta: float) -> void:
	# Update the polygon shape every frame
	var points = get_points_positions()
	if points.size() >= 3:
		# Enlarge the polygon
		var enlarged_points = enlarge_polygon(points, scale_factor)
		polygon.polygon = enlarged_points

# Function to get positions of all child nodes named "Point*"
func get_points_positions() -> Array:
	var positions = []
	
	for child in get_children():
		if child.name.begins_with("Point") and child is Node2D:
			positions.append(child.position)
	
	return positions

# Function to enlarge a polygon by scaling its vertices outward
func enlarge_polygon(vertices: Array, scale: float) -> Array:
	# Calculate the polygon's center
	var center = Vector2.ZERO
	for vertex in vertices:
		center += vertex
	center /= vertices.size()

	# Scale each vertex outward from the center
	var enlarged_vertices = []
	for vertex in vertices:
		var direction = (vertex - center).normalized()
		var new_vertex = center + direction * (vertex.distance_to(center) * scale)
		enlarged_vertices.append(new_vertex)

	return enlarged_vertices
