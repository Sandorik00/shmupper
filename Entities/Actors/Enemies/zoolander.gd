extends Area2D

@onready var health: int = 10
@export var bar: TextureProgressBar

var path: PathFollow2D
var pattern_start: bool = false

func take_damage(amount: int):
	health -= amount
	bar.value -= amount
	if health <= 0:
		queue_free()

func _ready() -> void:
	bar.value = 10

func _process(_delta: float) -> void:
	if ((path.progress_ratio >= 0.5) and !pattern_start):
		pattern_start = true
		BulletsContext.shoot_arc(self)
