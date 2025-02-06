extends Area2D


func _process(delta: float) -> void:
	position.y = position.y + (600 * delta)
	
	if position.y < -50:
		queue_free()
