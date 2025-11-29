extends AbstractPattern

var adjusted_rotation: float = 0

func _ready() -> void:
	super ()
	for i in range(-5, 6):
			var bullet = BulletPool.get_bullet() as Bullet
			var bullet_offset = entity.global_position
			bullet_offset += Vector2(i * 15, -70 + abs(i * 20)).rotated(entity.rotation + adjusted_rotation)
			bullet.position = bullet_offset
			bullet.prepare(entity.rotation + adjusted_rotation)

	finished = true
