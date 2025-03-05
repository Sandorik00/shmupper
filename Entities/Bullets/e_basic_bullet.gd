extends Bullet

func _ready():
	super()


func _process(delta):
	super(delta)

func _on_area_entered(area:Area2D) -> void:
	if area.collision_layer == 4:
		area.take_damage(1)
		self.queue_free()
