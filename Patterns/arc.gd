extends AbstractPattern

var entity: Node2D
var one_bullet: PackedScene
var adjusted_rotation: float = 0

func _ready() -> void:
	super()
	for i in range(-5, 6):
			var bullet = one_bullet.instantiate()
			bullet.prepare(entity.rotation + adjusted_rotation)
			var bullet_offset = entity.global_position
			bullet_offset += Vector2(i * 15, -70 + abs(i * 20)).rotated(entity.rotation + adjusted_rotation)
			bullet.position = bullet_offset
			self.add_child(bullet)

	finished = true
