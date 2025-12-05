extends Sprite2D

var hitbox_radius: float = 8

func _draw() -> void:
	draw_circle(Vector2.ZERO, hitbox_radius, Color.RED, true, -1.0, true)