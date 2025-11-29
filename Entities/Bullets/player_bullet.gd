extends Bullet

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		area.take_damage(1)
		BulletPool.free_bullet(self, true)

func _process(delta):
	super (delta)

	if not ScreenBorders.game_field.has_point(global_position):
		BulletPool.free_bullet(self, true)