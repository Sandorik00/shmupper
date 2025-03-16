extends AbstractPattern

var adjusted_rotation: float = 0
var bullets_qty = 36

func _ready() -> void:
	super()

	for i in range(bullets_qty):
		var angle = deg_to_rad(-180 + i * (360.0 / bullets_qty))
		var bullet = one_bullet.instantiate()
		bullet.prepare(entity.rotation + adjusted_rotation + angle)

		var bullet_offset = entity.global_position
		bullet_offset += Vector2(cos(angle) * 100, sin(angle) * 100)
		bullet.position = bullet_offset

		self.add_child(bullet)

	finished = true
