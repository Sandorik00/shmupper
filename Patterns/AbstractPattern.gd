class_name AbstractPattern extends Node2D

var timer: Timer
var finished: bool = false

func _ready():
	timer = get_node("/root/MainNode/PatternTimer")
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if finished and get_child_count() == 0:
		queue_free()
