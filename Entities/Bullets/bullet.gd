class_name Bullet extends Area2D

var initial_rotate: float
var initial_pos: Vector2

func _ready() -> void:
	initial_pos = position

func _process(delta: float) -> void:
	position += Vector2.UP.rotated(initial_rotate) * 600 * delta
	
	if abs(initial_pos.x - position.x) > 1000 || abs(initial_pos.y - position.y) > 1000:
		queue_free()

##Supply rotation to bullet
func prepare(_rotation: float) -> void:
	initial_rotate = _rotation
