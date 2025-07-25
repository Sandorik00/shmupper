extends Area2D

@export var pbullet_ps: PackedScene
@export var speed := 200
@export var san_woke: Texture2D
@export var sancheese: Texture2D
@export var HUD: CanvasLayer

var screen_size := Vector2.ZERO
var mainNode
var shoot_timer: Timer
var hit_cooldown: Timer
var can_take_damage: bool

func _ready() -> void:
	can_take_damage = true
	screen_size = Vector2(get_viewport_rect().size.x - $/root/MainNode/HUD/PanelAnchor/StatusPanel.size.x, get_viewport_rect().size.y)
	get_tree().root.connect("size_changed", _on_viewport_size_changed)
	
	mainNode = $/root/MainNode
	shoot_timer = mainNode.get_node("ShootTimer") as Timer

	#Engine.time_scale = 0.5

func _on_viewport_size_changed() -> void:
	var vector = Vector2.ZERO
	vector.y = get_viewport_rect().size.y
	vector.x = ScreenBorders.right_border
	screen_size = vector

func _process(delta):
	#MOVE
	var movement := Vector2(Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left"),
		Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up"))
		
	movement = speed * movement.normalized()
	position += movement * delta
	position = position.clamp(Vector2(ScreenBorders.left_border, 0), screen_size)
	
	#look_at(get_global_mouse_position())
	#rotation += PI/2
	
	#print(Vector2(get_global_mouse_position().x / 2, get_global_mouse_position().y))
	
	#SHOOT
	if Input.is_action_pressed("shoot"):
		$Sprite.texture = san_woke
		
		if shoot_timer.is_stopped():
			for n in 1:
				var copy = pbullet_ps.instantiate()
				var copy2 = pbullet_ps.instantiate()
				copy.prepare(self.rotation)
				copy2.prepare(self.rotation)
				var bullet_offset_1 = self.global_position
				var bullet_offset_2 = self.global_position
				bullet_offset_1 += Vector2(-20, -70)
				bullet_offset_2 += Vector2(20, -70)
				copy.position = bullet_offset_1
				copy2.position = bullet_offset_2
				mainNode.add_child(copy)
				mainNode.add_child(copy2)
				shoot_timer.start()
		
	else:
		$Sprite.texture = sancheese
	
func take_damage(amount: int):
	if can_take_damage:
		can_take_damage = false
		HUD.take_damage(amount, self)

		var tween = get_tree().create_tween()
		tween.finished.connect(_on_invinsibility_tween_end)
		tween.tween_property($Sprite, "modulate:a", 0.5, 0.1)
		tween.tween_property($Sprite, "modulate:a", 1, 0.1)
		tween.set_loops(14)
		#await tween.finished

func _on_invinsibility_tween_end():
	can_take_damage = true
