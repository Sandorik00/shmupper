extends Area2D

@onready var health: int = 100

var path: PathFollow2D
var pattern_start: bool = false

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()

func _process(_delta: float) -> void:
	if ((path.progress_ratio >= 1) and !pattern_start):
		pattern_start = true
		BulletsContext.shoot_utsuho_fuck_you(self)
