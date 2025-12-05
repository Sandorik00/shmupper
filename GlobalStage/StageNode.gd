extends Node2D

@export var pathsCollection: Node2D

enum ENEMY_TYPES {FAIRY, PARADOX, ZOOLANDER, ZLOY_PARADOX, PARA_PARA}

enum PERSISTENCE_TYPES {BASIC, STAYS, BOSS}

class StageEvent:
	var enemy_type: ENEMY_TYPES
	var path_name: String
	var pause: float
	var wait: bool
	var tween_duration: float
	var persistence: PERSISTENCE_TYPES
	
	func _init(
		_enemy_type: ENEMY_TYPES,
		_path_name: String,
		_pause: float,
		_wait: bool,
		_tween_duration: float,
		_persistence: PERSISTENCE_TYPES = PERSISTENCE_TYPES.BASIC,
	):
		enemy_type = _enemy_type
		path_name = _path_name
		pause = _pause
		wait = _wait
		tween_duration = _tween_duration
		persistence = _persistence


var events: Array[StageEvent] = [
	StageEvent.new(ENEMY_TYPES.FAIRY, "RightSlideAndLeave", 0, false, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "LeftSlideAndLeave", 0.2, false, 3),
	StageEvent.new(ENEMY_TYPES.ZOOLANDER, "LeftSlideAndLeave", 0, true, 5),
	# StageEvent.new(ENEMY_TYPES.ZOOLANDER, "RightSlideAndLeave", 1, true, 5),
	StageEvent.new(ENEMY_TYPES.FAIRY, "LeftSlideAndLeave", 1, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "RightSlideAndLeave", 1, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "LeftSlideAndLeave", 1, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "RightSlideAndLeave", 0, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "LeftSlideAndLeave", 0, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "RightSlideAndLeave", 0, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "LeftSlideAndLeave", 0, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "RightSlideAndLeave", 2, true, 3),
	StageEvent.new(ENEMY_TYPES.FAIRY, "LeftSlideAndLeave", 2, true, 3),
	StageEvent.new(ENEMY_TYPES.ZLOY_PARADOX, "StraightAndWhite", 1, true, 3, PERSISTENCE_TYPES.BOSS),
	# StageEvent.new(ENEMY_TYPES.PARA_PARA, "StraightAndWhite", 0.2, false, 3, PERSISTENCE_TYPES.STAYS),
]
var stage_timer := Timer.new()
var current_event: StageEvent

func _ready() -> void:
	_loop()

func _process(_delta: float):
	if Input.is_action_just_pressed("fullscreen"):
		var current_mode = DisplayServer.window_get_mode()
		var next_mode = DisplayServer.WINDOW_MODE_FULLSCREEN if current_mode == DisplayServer.WINDOW_MODE_WINDOWED else DisplayServer.WINDOW_MODE_WINDOWED
		DisplayServer.window_set_mode(next_mode)

func _loop():
	while events.size() != 0:
		var event: StageEvent = events.pop_front()
		var enemy = await enemy_setup(event)

		if (event.persistence == PERSISTENCE_TYPES.BOSS):
			await enemy.tree_exited

		await create_tween().tween_interval(event.pause).finished

func enemy_setup(event: StageEvent):
	var enemy_and_follow = create_enemy_and_follow(event.enemy_type, event.path_name)

	var follow = enemy_and_follow[1]
	var enemy = enemy_and_follow[0]

	var tween = get_tree().create_tween()
	tween.tween_property(follow, "progress_ratio", 1, event.tween_duration)
	# if (event.persistence == PERSISTENCE_TYPES.BASIC):
	# 	tween.tween_callback(follow.queue_free)
	
	if (not event.wait): return enemy

	await tween.finished
	return enemy

func create_enemy_and_follow(enemy_type: ENEMY_TYPES, path: String) -> Array:
	var enemy = create_enemy(enemy_type)
	var follow = create_follow(path, enemy)
	return [enemy, follow]

func create_follow(path: String, enemy: Node2D) -> PathFollow2D:
	var pathNode = pathsCollection.get_node("%s" % path)
	var pathFollow = PathFollow2D.new()
	pathFollow.loop = false
	pathFollow.rotates = false
	pathFollow.add_child(enemy)
	pathNode.add_child(pathFollow)
	enemy.path = pathFollow
	return pathFollow

func create_enemy(enemy_type: ENEMY_TYPES) -> Node2D:
	var enemy = ResourceLoader.load(
		"res://Entities/Actors/Enemies/%s.tscn" % ENEMY_TYPES.keys()[enemy_type].to_lower(),
		"PackedScene"
	).instantiate()
	return enemy
