extends Bullet

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)

func _on_area_entered(area:Area2D) -> void:
	if area.collision_layer == 2:
		area.take_damage(1)
		self.queue_free()
