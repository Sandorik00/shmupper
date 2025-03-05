extends Node

var HP = 3

func take_damage(amount: int, player: Node2D):
	HP -= amount

	if HP <= 0:
		player.queue_free()