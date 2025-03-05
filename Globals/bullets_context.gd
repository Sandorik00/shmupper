extends Node

@onready var main_node = get_node("/root/MainNode")
@onready var one_bullet = ResourceLoader.load("res://Entities/Bullets/e_basic_bullet.tscn", "PackedScene")

func shoot_one_bullet(entity: Node2D):
	var copy = one_bullet.instantiate()
	copy.prepare(entity.rotation)
	main_node.add_child(copy)
	var bullet_offset = entity.global_position
	bullet_offset += Vector2(0, -70).rotated(entity.rotation)
	copy.position = bullet_offset
