extends Area2D
var getback=0
var animlock=false
var slowlock = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if getback>0:
		getback-=delta
	else:
		getback=0
	if getback==0 and !animlock:
		slow_down_simulation(1.0) 
		$CrabAnimator.speed_scale=1
		$CrabAnimator.play("Jump_In")
		animlock=true


func _on_body_entered(body: Node2D) -> void:
	if body.name=="Center" and not $CrabAnimator.current_animation=="Jump_Out":
		if body.get_parent().has_method("explode"):
			body.get_parent().explode()
			$CrabAnimator.speed_scale=1
			$CrabAnimator.play("Nhac")
			$CrabAnimator.seek(0, true)
	if body.is_in_group("ball") and getback==0:
		body.apply_central_force(Vector2(-35,-5))
		$CrabAnimator.play("Jump_Out")
		
		animlock=false
		if not slowlock:
			$CrabAnimator.speed_scale=11
			slow_down_simulation(0.03)
			slowlock=true
			
		getback=0.3
		 
		
func slow_down_simulation(factor: float) -> void:
	Engine.time_scale = clampf(factor, 0.1, 1.0)  # Clamp to avoid extreme values
