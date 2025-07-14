class_name DefaultEnemy extends Area2D

@onready var health: int = 8
@export var bar: TextureProgressBar

var path: PathFollow2D
var pattern_start: bool = false

func take_damage(amount: int):
	health -= amount
	bar.value -= amount
	if health <= 0:
		queue_free()

func _ready() -> void:
	bar.max_value = health
	bar.value = health
