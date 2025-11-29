extends Node

var e_bullet_pool: Array[Bullet] = []
var p_bullet_pool: Array[Bullet] = []

@onready var main_node = get_node("/root/MainNode")
@onready var one_bullet: PackedScene = ResourceLoader.load("res://Entities/Bullets/e_basic_bullet.tscn")
@onready var p_bullet: PackedScene = ResourceLoader.load("res://Entities/Bullets/player_bullet.tscn")

func get_bullet(is_player: bool = false) -> Bullet:
	if is_player: return get_or_create_bullet(p_bullet_pool, p_bullet)
	return get_or_create_bullet(e_bullet_pool, one_bullet)

func free_bullet(bullet: Bullet, is_player: bool = false):
	reset_bullet(bullet)

	if is_player: p_bullet_pool.push_back(bullet)
	else: e_bullet_pool.push_back(bullet)


# Utils
func get_or_create_bullet(pool: Array[Bullet], bullet_scene: PackedScene) -> Bullet:
	if pool.is_empty():
		var instance = bullet_scene.instantiate()
		reset_bullet(instance)
		main_node.add_child(instance)
		return instance

	var bullet = pool.pop_back() as Bullet
	return bullet

func reset_bullet(bullet: Bullet):
	bullet.hide()
	bullet.position = Vector2(-10, -10)
	bullet.set_process(false)
