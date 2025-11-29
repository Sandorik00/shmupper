extends Area2D

@export var pbullet_ps: PackedScene
@export var speed := 100
@export var san_woke: Texture2D
@export var sancheese: Texture2D
@export var HUD: CanvasLayer

var screen_size := {min: Vector2.ZERO, max: Vector2.ZERO}
var mainNode
var shoot_timer: Timer
var hit_cooldown: Timer
var can_take_damage: bool

@onready var statusPanel = HUD.get_node("PanelAnchor/StatusPanel")
@onready var leftPanel = HUD.get_node("PanelLeft/ColorRect")
@onready var topPanel = HUD.get_node("PanelTop/ColorRect")
@onready var bottomPanel = HUD.get_node("PanelBottom/ColorRect")

func _ready() -> void:
	can_take_damage = true
	screen_size.max = Vector2(get_viewport_rect().size.x - statusPanel.size.x, get_viewport_rect().size.y - bottomPanel.size.y)
	screen_size.min = Vector2(leftPanel.size.x, topPanel.size.y)
	ScreenBorders.set_screen_size(screen_size)
	get_tree().root.connect("size_changed", _on_viewport_size_changed)
	
	mainNode = $/root/MainNode
	shoot_timer = mainNode.get_node("ShootTimer") as Timer

	#Engine.time_scale = 0.5

func _on_viewport_size_changed() -> void:
	screen_size.max = Vector2(get_viewport_rect().size.x - statusPanel.size.x, get_viewport_rect().size.y - bottomPanel.size.y)
	screen_size.min = Vector2(leftPanel.size.x, topPanel.size.y)
	ScreenBorders.set_screen_size(screen_size)

func _process(delta):
	#MOVE
	var movement := Vector2(Input.get_action_strength("camera_right") - Input.get_action_strength("camera_left"),
		Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up"))

	if movement.x > 0:
		$Animation.animation = "right"
	elif movement.x < 0:
		$Animation.animation = "left"
	else:
		$Animation.animation = "default"
		
	movement = speed * movement.normalized()
	position += movement * delta
	position = position.clamp(screen_size.min, screen_size.max)
	
	#look_at(get_global_mouse_position())
	#rotation += PI/2
	
	#print(Vector2(get_global_mouse_position().x / 2, get_global_mouse_position().y))
	
	#SHOOT
	if Input.is_action_pressed("shoot"):
		if shoot_timer.is_stopped():
			for n in 1:
				var copy = BulletPool.get_bullet(true)
				var copy2 = BulletPool.get_bullet(true)
				var bullet_offset_1 = self.global_position
				var bullet_offset_2 = self.global_position
				bullet_offset_1 += Vector2(-10, -35)
				bullet_offset_2 += Vector2(10, -35)
				copy.position = bullet_offset_1
				copy2.position = bullet_offset_2
				copy.prepare(self.rotation)
				copy2.prepare(self.rotation)
				shoot_timer.start()
	
func take_damage(amount: int):
	if can_take_damage:
		can_take_damage = false
		PlayerContext.take_damage(amount, self)

		var tween = get_tree().create_tween()
		tween.finished.connect(_on_invinsibility_tween_end)
		tween.tween_property($Animation, "modulate:a", 0.5, 0.1)
		tween.tween_property($Animation, "modulate:a", 1, 0.1)
		tween.set_loops(14)
		#await tween.finished

func _on_invinsibility_tween_end():
	can_take_damage = true
