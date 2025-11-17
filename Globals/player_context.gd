extends Node

signal hp_change(hp: int)

var HP := 3

func get_hp() -> int:
	return HP

func take_damage(amount: int, player: Node2D):
	HP -= amount

	hp_change.emit(HP)

	if HP <= 0:
		player.queue_free()