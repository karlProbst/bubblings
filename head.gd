extends RigidBody2D


@onready var plin_sound = preload("res://Assets/Sound/plinMetal.mp3") 
@onready var diaxo_sound = preload("res://Assets/Sound/diachometal.mp3") 
var diaxo=0
var anzol_stiffness=0
var ganchando=false
var stateGancho=0
@onready var anzolnode = get_parent().get_node("anzolpin")
@export var linha:Node2D
var fishnode:Node2D
var reeled=false
var soltar = false
func _ready():
	anzol_stiffness=anzolnode.stiffness
func processLine(nodea: Node2D, nodeb: Node2D) -> void:
	
	var position_a = nodea.position +Vector2(-15,50)
	var position_b = nodeb.position+get_parent().get_node("ponta").position
	linha.set_point_position(0, position_a)
	linha.set_point_position(1, position_b)

func _process(delta):
	
	
	if diaxo>0:
		diaxo-=delta
	if not reeled:
		processLine(get_parent().get_node("anzol"),get_parent().get_node("ponta/Cerejaa"))
		if not ganchando:
			if anzolnode.stiffness<anzol_stiffness:
				anzolnode.stiffness+=delta/3
			if anzolnode.stiffness<0:
				anzolnode.stiffness=0
		else:
			if anzolnode.stiffness<16:
				get_parent().get_node("AnimationPlayer").play("varadown")
				get_parent().get_node("AnimationPlayer").speed_scale=2
				anzolnode.stiffness+=delta*3
			else:
				if stateGancho==0:
					get_parent().get_node("AnimationPlayer").speed_scale=1
					get_parent().get_node("AnimationPlayer").play("reeling")
					stateGancho=1
				
			
func play_sound_effect(sound: AudioStream, position: Vector2) -> void:
	# Create a new AudioStreamPlayer2D instance
	var sound_player = AudioStreamPlayer2D.new()

	# Set the sound stream and position
	sound_player.stream = sound
	sound_player.global_position = position
	sound_player
	# Add the sound player to the current scene tree
	get_parent().add_child(sound_player)
	# Play the sound
	sound_player.play()

	# Queue the sound player for deletion after it finishes playing
	sound_player.connect("finished", Callable(sound_player, "queue_free"))


func _on_body_entered(body: Node) -> void:
	if body.name=="Center":
		if !ganchando:
			get_parent().get_node("anzolpin").stiffness-=0.4
			get_parent().get_node("AnimationPlayer").play("varadown")
			get_parent().get_node("AnimationPlayer").seek(0,true)
	if body.is_in_group("ball"):
		if reeled:
			get_parent().get_node("anzolpin").queue_free()
			get_parent().get_node("anzol/anzol").queue_free()
			linha.queue_free()
			soltar=true
		play_sound_effect(plin_sound, position)
		if diaxo<=0:
			play_sound_effect(diaxo_sound, position)
			diaxo=40
		if !ganchando:
			get_parent().get_node("anzolpin").stiffness-=0.9


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="reeling":
		get_parent().get_node("AnimationPlayer").play("reeled")
		fishnode.global_transform.origin=get_parent().get_node("anzol").global_transform.origin
		reeled=true
