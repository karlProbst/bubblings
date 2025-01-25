extends RigidBody2D


@onready var plin_sound = preload("res://Assets/Sound/plinMetal.mp3") 
@onready var diaxo_sound = preload("res://Assets/Sound/diachometal.mp3") 
var diaxo=0
var anzol_stiffness=0
var ganchando=false
@onready var anzolnode = get_parent().get_node("anzolpin")
func _ready():
	anzol_stiffness=anzolnode.stiffness
func _process(delta):
	if diaxo>0:
		diaxo-=delta
	
	if not ganchando:
		if anzolnode.stiffness<anzol_stiffness:
			anzolnode.stiffness+=delta/2
		if anzolnode.stiffness<0:
			anzolnode.stiffness=0
	else:
		if anzolnode.stiffness<16:
			anzolnode.stiffness+=delta
		else:
			pass
		
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
		get_parent().get_node("anzolpin").stiffness-=0.3
		get_parent().get_node("AnimationPlayer").play("varadown")
		get_parent().get_node("AnimationPlayer").seek(0,true)
	if body.is_in_group("ball"):
		get_parent().get_node("anzolpin").stiffness-=0.8
		print(body.linear_velocity)
		play_sound_effect(plin_sound, position)
		if diaxo<=0:
			play_sound_effect(diaxo_sound, position)
			diaxo=40
