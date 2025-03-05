extends ColorRect

@export var is_left: bool

func _ready() -> void:
	connect("resized", _on_resized)
	if is_left:
		ScreenBorders.set_left_border(size.x)
	else:
		ScreenBorders.set_right_border(get_viewport_rect().size.x - size.x)

func _on_resized():
	if is_left:
		ScreenBorders.set_left_border(size.x)
	else:
		ScreenBorders.set_right_border(get_viewport_rect().size.x - size.x)

func _process(delta: float) -> void:
	pass
