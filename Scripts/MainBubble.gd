extends Node2D

# Reference to the Polygon2D node
var polygon: Polygon2D
# Reference to the shader resource
var SHADER = preload("res://Shaders/BubbleShader.gdshader")
# Scaling factor for enlarging the polygon
var scale_factor: float = 1.3
# Number of subdivisions per edge to add smoothness
var subdivisions: int = 2
#explosion 
@export var force_threshold: float =85000.0
@onready var NodePoints = []
var exploded=false
# Called when the node enters the scene tree
func _ready():
	
	NodePoints.append($Center)
	for child in get_children():
		if child.name.begins_with("Point") and child is RigidBody2D:
			child.get_child(0).scale=$Center.scale
			NodePoints.append(child)
			

	# Create the Polygon2D node
	polygon = $Polygon2D
	
	
	# Assign a shader material to the polygon
	

# Called every frame
func _process(delta: float) -> void:
	
	# Update the polygon shape every frame
	var points = get_points_positions()
	if points.size() >= 3:
		# Enlarge the polygon
		var enlarged_points = enlarge_polygon(points, scale_factor)
		# Subdivide the polygon to add smoothness
		var smoothed_points = subdivide_polygon(enlarged_points, subdivisions)
		polygon.polygon = smoothed_points
	if should_explode() or exploded:
		explode()


# Check if the bubble should explode based on forces


func should_explode() -> bool:
	if NodePoints.size() < 2:
		return false

	# Calculate the maximum and minimum forces on the points
	var max_force = 0.0
	var min_force = INF
	for point in NodePoints:
		var force = point.linear_velocity.length()
		max_force = max(max_force, force)
		min_force = min(min_force, force)

	# Check if the difference exceeds the threshold
	return (max_force - min_force) > force_threshold

# Trigger the explosion
func explode():
	var sound = preload("res://Assets/Sound/bup.mp3")  # Replace with your sound file's path
	play_sound_effect(sound, self.global_position)

	print("Bubble exploded!")
	queue_free()



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

# Function to subdivide a polygon's edges to add smoothness
func subdivide_polygon(vertices: Array, subdivisions: int) -> Array:
	if subdivisions <= 0:
		return vertices

	var smoothed_vertices = []
	for i in range(vertices.size()):
		var start = vertices[i]
		var end = vertices[(i + 1) % vertices.size()]  # Wrap around to the first point
		smoothed_vertices.append(start)

		# Add interpolated points between start and end
		for j in range(1, subdivisions + 1):
			var t = float(j) / (subdivisions + 1)
			var interpolated = lerp(start,end, t)
			smoothed_vertices.append(interpolated)

	return smoothed_vertices


func _on_center_body_entered(body: Node) -> void:
	if not body.is_in_group("ball"):
		exploded=true


func play_sound_effect(sound: AudioStream, position: Vector2) -> void:
	# Create a new AudioStreamPlayer2D instance
	var sound_player = AudioStreamPlayer2D.new()

	# Set the sound stream and position
	sound_player.stream = sound
	sound_player.global_position = position
	sound_player
	# Add the sound player to the current scene tree
	get_parent().add_child(sound_player)
	print(sound_player)
	# Play the sound
	sound_player.play()

	# Queue the sound player for deletion after it finishes playing
	sound_player.connect("finished", Callable(sound_player, "queue_free"))
