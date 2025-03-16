class_name ComplexPattern extends AbstractPattern

var pattern_queue: Array[BulletsContext.PatternEvent] = []
var pattern_timer: float = 0
var time_passed: float = 0

func _ready() -> void:
	super()
	time_passed = Time.get_ticks_msec() / 1000.0
	_loop()

	finished = true

func _loop():
	for pattern in pattern_queue:
		var pattern_scene = BulletsContext.get("%s" % BulletsContext.PATTERN_TYPES.keys()[pattern.pattern_type].to_lower()).instantiate()
		pattern_scene.entity = self.entity
		pattern_scene.one_bullet = self.one_bullet
		pattern_scene.adjusted_rotation = PI/2
		self.add_child(pattern_scene)
		await get_tree().process_frame
		await create_tween().tween_interval(pattern.pause).finished


# Вариант потенциально лучше, но точность гораздо ниже из-за ограниченного количества вызово process и потери излишков времени дельты.
# func _process(_delta):
# 	var cringe_delta = (Time.get_ticks_msec() / 1000.0) - time_passed
# 	if finished: return

# 	if pattern_timer <= 0:
# 		var pattern = pattern_queue.pop_front()

# 		if pattern == null:
# 			finished = true
# 			return

# 		var pattern_scene = BulletsContext.get("%s" % BulletsContext.PATTERN_TYPES.keys()[pattern.pattern_type].to_lower()).instantiate()
# 		pattern_scene.entity = self.entity
# 		pattern_scene.one_bullet = self.one_bullet
# 		pattern_scene.adjusted_rotation = PI/2
# 		self.add_child(pattern_scene)
# 		pattern_timer += pattern.pause
# 		time_passed += cringe_delta
# 		pattern_timer -= cringe_delta

# 	else:
# 		print("DELTA: %s" % cringe_delta)
# 		pattern_timer -= cringe_delta
# 		time_passed += cringe_delta

		
