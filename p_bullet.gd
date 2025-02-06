extends Area2D

class_name PBullet

var initial_rotate: float
var initial_pos: Vector2

func _ready() -> void:
	initial_pos = position
	
func prepare(rotation: float) -> void:
	initial_rotate = rotation

func _process(delta: float) -> void:
	#position += Vector2.UP.rotated(initial_rotate) * 600 * delta
	position += Vector2.UP.rotated(initial_pos.angle_to(get_global_mouse_position()))
	print(get_global_mouse_position().angle_to(initial_pos))
	
	if position.y < -50:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	area.take_damage(1)
	self.queue_free()
