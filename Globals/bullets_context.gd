extends Node

enum PATTERN_TYPES {ONE_BULLET, ARC, UTSUHO_FUCK_YOU, SPREAD_SHOTS, ONE_BULLET_HOMING}

class PatternEvent:
	var pattern_type: PATTERN_TYPES
	var pause: float
	var wait: bool
	
	func _init(_pattern_type: PATTERN_TYPES, _pause: float, _wait: bool):
		pattern_type = _pattern_type
		pause = _pause
		wait = _wait

@onready var main_node = get_node("/root/MainNode")
@onready var player = main_node.get_node("Player")
@onready var one_bullet = ResourceLoader.load("res://Entities/Bullets/e_basic_bullet.tscn", "PackedScene")
@onready var arc = ResourceLoader.load("res://Patterns/arc.tscn", "PackedScene")
@onready var utsuho_fuck_you = ResourceLoader.load("res://Patterns/utsuho_fuck_you.tscn", "PackedScene")
@onready var spread_shots = ResourceLoader.load("res://Patterns/spread_shots.tscn", "PackedScene")
@onready var one_bullet_homing = ResourceLoader.load("res://Patterns/one_bullet_homing.tscn", "PackedScene")

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


func shoot_utsuho_fuck_you(entity: Node2D):
	var utsuho_fuck_you_scene = utsuho_fuck_you.instantiate()
	utsuho_fuck_you_scene.entity = entity
	utsuho_fuck_you_scene.one_bullet = one_bullet
	for i in range(100):
		utsuho_fuck_you_scene.pattern_queue.append(PatternEvent.new(BulletsContext.PATTERN_TYPES.SPREAD_SHOTS, 0.02, true))
	main_node.add_child(utsuho_fuck_you_scene)

func shoot_one_bullet_homing(entity: Node2D):
	var copy = one_bullet.instantiate()
	copy.prepare(entity.rotation, player)
	copy.change_speed(300)
	copy.change_homing_strength(0.3)
	var bullet_offset = entity.global_position
	bullet_offset += Vector2(0, -70).rotated(entity.rotation)
	copy.position = bullet_offset
	main_node.add_child(copy)
