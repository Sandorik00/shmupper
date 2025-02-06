extends Area2D

@onready var health: int = 8
@export var bar: TextureProgressBar

func take_damage(amount: int):
	health -= amount
	bar.value -= amount
	if health <= 0:
		queue_free()

func _ready() -> void:
	bar.value = 10

func _process(delta: float) -> void:
	pass
