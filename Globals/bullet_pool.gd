extends Node

var e_bullet_pool: Array[Bullet] = []
var p_bullet_pool: Array[Bullet] = []

# var e_index: int = 0
# var p_index: int = 0

@onready var one_bullet: PackedScene = ResourceLoader.load("res://Entities/Bullets/e_basic_bullet.tscn")
@onready var p_bullet: PackedScene = ResourceLoader.load("res://Entities/Bullets/player_bullet.tscn")

# func _ready():
# 	for i in 1000:
# 		var e = one_bullet.instantiate()
# 		var p = p_bullet.instantiate()
# 		e_bullet_pool.push_back(e)
# 		p_bullet_pool.push_back(p)


func get_bullet(is_player: bool = false) -> Bullet:
	if is_player: return get_or_create_bullet(p_bullet_pool, p_bullet)
	else: return get_or_create_bullet(e_bullet_pool, one_bullet)

func free_bullet(bullet: Bullet, is_player: bool = false):
	bullet.get_parent().remove_child(bullet)
	bullet.position = Vector2(-10, -10)

	if is_player: p_bullet_pool.push_back(bullet)
	else: e_bullet_pool.push_back(bullet)


# Utils
func get_or_create_bullet(pool: Array[Bullet], bullet_scene: PackedScene) -> Bullet:
	if pool.is_empty():
		return bullet_scene.instantiate()

	var bullet = pool.pop_back() as Bullet
	bullet.request_ready()
	return bullet
