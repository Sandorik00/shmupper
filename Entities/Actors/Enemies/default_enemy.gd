class_name DefaultEnemy extends Area2D

@onready var health: int = 8

var path: PathFollow2D
var pattern_start: bool = false
var hiding: bool = false

func _process(_delta: float):
	if pattern_start and not hiding and not ScreenBorders.game_field.has_point(global_position):
		hiding = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:a", 0, 1).set_trans(Tween.TRANS_LINEAR)
		tween.tween_callback(queue_free)

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()
