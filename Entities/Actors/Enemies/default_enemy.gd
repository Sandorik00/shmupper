class_name DefaultEnemy extends Area2D

@onready var health: int = 8

var path: PathFollow2D
var pattern_start: bool = false

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()
