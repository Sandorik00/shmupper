extends Node

@onready var main_node = get_node("/root/MainNode")
@onready var one_bullet = ResourceLoader.load("res://Entities/Bullets/e_basic_bullet.tscn", "PackedScene")
@onready var arc = ResourceLoader.load("res://Patterns/arc.tscn", "PackedScene")

func shoot_one_bullet(entity: Node2D):
	var copy = one_bullet.instantiate()
	copy.prepare(entity.rotation)
	var bullet_offset = entity.global_position
	bullet_offset += Vector2(0, -70).rotated(entity.rotation)
	copy.position = bullet_offset
	main_node.add_child(copy)


func shoot_arc(entity: Node2D):
	var arc_scene = arc.instantiate()
	arc_scene.entity = entity
	arc_scene.one_bullet = one_bullet
	main_node.add_child(arc_scene)
	
