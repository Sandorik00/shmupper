extends AbstractPattern

var entity: Node2D
var one_bullet: PackedScene

func _ready() -> void:
	super()
	for i in range(-5, 6):
			var bullet = one_bullet.instantiate()
			bullet.prepare(entity.rotation)
			var bullet_offset = entity.global_position
			bullet_offset += Vector2(i * 15, -70 + abs(i * 20)).rotated(entity.rotation)
			bullet.position = bullet_offset
			self.add_child(bullet)

	finished = true
