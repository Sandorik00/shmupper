extends Bullet
class_name EBasicBullet

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 4:
		area.take_damage(1)
		self.queue_free()

func _process(delta):
	super (delta)

	if not ScreenBorders.game_field.has_point(global_position):
		BulletPool.free_bullet(self)