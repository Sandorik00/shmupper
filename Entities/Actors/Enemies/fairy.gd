extends DefaultEnemy

func _process(_delta: float) -> void:
	super (_delta)
	if ((path.progress_ratio >= 0.5) and !pattern_start):
		pattern_start = true
		BulletsContext.shoot_directional_bullet(self)
