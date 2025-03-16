class_name Bullet extends Area2D

var initial_rotate: float
var initial_pos: Vector2

func _ready() -> void:
	initial_pos = position
	rotation = initial_rotate
	#Engine.time_scale = 0.1

func _process(delta: float) -> void:
	# I KNOW WHAT THE FUCK IS GOING ON HERE
	position += Vector2.UP.rotated(rotation) * 600 * delta
	
	if abs(initial_pos.x - position.x) > 1000 || abs(initial_pos.y - position.y) > 1000:
		queue_free()

##Supply rotation to bullet
func prepare(_rotation: float) -> void:
	initial_rotate = _rotation
