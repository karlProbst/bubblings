extends Sprite2D
@export var camera : Node2D
var a=0
var width=550
var max=4.245
var mscale=4.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var window_size = DisplayServer.window_get_size()
	var width = window_size.x
	mscale=width/128.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	a+=delta
	scale.x=sin(a)+2*a
	scale.x*=2.5
	
	if(camera.zoom.x<mscale/scale.x):
		camera.zoom.x=mscale/scale.x
	camera.zoom.y=camera.zoom.x
	
	
	
