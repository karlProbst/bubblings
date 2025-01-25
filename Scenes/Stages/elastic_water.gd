extends Node2D

var raycasts=[]
@onready var polygon = $WaterPolygon # Semi-transparent blue
var points=[]
var primaryPos=[Vector2(524,0),Vector2(524,3300),Vector2(-600,3300),Vector2(-600,0)]
func _ready():
	for child in self.get_children():
		if child.name.begins_with("Point"):
			points.append(child)
	raycasts = createRays(points)
func _process(delta):
	getPointsPos()
	_update_polygon()
	updateRayPos(points,raycasts)
	check_raycasts_hits(raycasts)
func updateRayPos(arrayOfNodes,raycasts):
	for i in range(arrayOfNodes.size()):
		raycasts[i].position=arrayOfNodes[i].position
func createRays(arrayOfNodes):
	var raycasts=[]
	for node in arrayOfNodes:
		var raycast = RayCast2D.new()
		raycast.position = node.position
		raycast.target_position=Vector2(0,10)
		raycast.enabled = true
		add_child(raycast)
		raycasts.append(raycast)
	return raycasts
func getPointsPos():
	var posArray=[]
	for p in points:
		posArray.append(p.position)
	posArray= posArray+primaryPos
	return posArray
func _update_polygon():
	polygon.polygon = getPointsPos()
	
func check_raycasts_hits(raycasts: Array):
	for i in range(raycasts.size()):
		var raycast=raycasts[i]
		if raycast and raycast is RayCast2D:
			raycast.force_raycast_update()
			if raycast.is_colliding():
				
				var col=raycast.get_collider()
			
				if col.is_in_group("dumbfish"):
					col.apply_central_force(Vector2(0,-3000))
				if col.is_in_group("ball"):
					points[i].apply_central_force(col.linear_velocity*3.5)
				if col.name=="Center":
					points[i].apply_central_force(col.linear_velocity)



	
