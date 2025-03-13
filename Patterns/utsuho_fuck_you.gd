extends AbstractPattern

var entity: Node2D
var one_bullet: PackedScene

var pattern_queue: Array[BulletsContext.PatternEvent] = [
	BulletsContext.PatternEvent.new(BulletsContext.PATTERN_TYPES.ARC, 2, true),
	BulletsContext.PatternEvent.new(BulletsContext.PATTERN_TYPES.ARC, 2, true)
]

func _ready() -> void:
	super()
	_loop()

	finished = true

func _loop():
	for pattern in pattern_queue:
		var pattern_scene = BulletsContext.get("%s" % BulletsContext.PATTERN_TYPES.keys()[pattern.pattern_type].to_lower()).instantiate()
		pattern_scene.entity = entity
		pattern_scene.one_bullet = one_bullet
		pattern_scene.adjusted_rotation = PI
		self.add_child(pattern_scene)
		await create_tween().tween_interval(pattern.pause).finished