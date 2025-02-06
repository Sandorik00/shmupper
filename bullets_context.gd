extends Node

class_name Bullets

@onready var main_node = get_node("/root/MainNode")

func shoot_one_bullet(entity: Node2D, bullet: PackedScene):
	var copy = bullet.instantiate()
	copy.prepare(entity.rotation)
	main_node.add_child(copy)
	var bullet_offset = entity.global_position
	bullet_offset += Vector2(0, -70).rotated(entity.rotation)
	copy.position = bullet_offset
