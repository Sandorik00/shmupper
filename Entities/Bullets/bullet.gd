class_name Bullet extends Area2D

var initial_rotate: float
var initial_pos: Vector2
var additional_speed: int = 600
var player: Node2D
var homing_strength: float = 1

func _ready() -> void:
	initial_pos = position
	rotation = initial_rotate
	#Engine.time_scale = 0.1

func _process(delta: float) -> void:
	position += Vector2.UP.rotated(rotation) * additional_speed * delta

	if player != null:
		var to_target = player.global_position - global_position
		var target_angle = to_target.rotated(PI / 2).angle()

		# Adjust the target angle with a correction factor
		var current_angle = rotation
		var angle_difference_b = target_angle - current_angle

		# Wrap the angle difference to stay within -PI to PI range
		angle_difference_b = wrapf(angle_difference_b, -PI, PI)

		# Apply homing strength and correction
		var desired_rotation = current_angle + angle_difference_b * homing_strength

		# Rotate towards the target
		rotation = lerp_angle(current_angle, desired_rotation, 10 * delta)
	
	if not get_viewport_rect().has_point(global_position):
		queue_free()

##Supply rotation to bullet
func prepare(_rotation: float, _player: Node2D = null) -> void:
	initial_rotate = _rotation
	player = _player

func change_speed(_speed: int) -> void:
	additional_speed = _speed

func change_homing_strength(_strength: float) -> void:
	homing_strength = _strength
