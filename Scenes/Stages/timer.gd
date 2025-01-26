extends Node

# Variables to track time
var elapsed_time: int = 0
var timer_active: bool = false

func _ready():
	start_timer()

func start_timer():
	elapsed_time = 0
	timer_active = true


func stop_timer():
	timer_active = false


func reset_timer():
	elapsed_time = 0

func _process(delta: float):
	if timer_active:
		elapsed_time += int(delta * 1000)
		update_timer_display()

func update_timer_display():
	var seconds = elapsed_time / 1000
	var milliseconds = elapsed_time % 1000
	$Label.text=("%d.%03d" % [seconds, milliseconds])
