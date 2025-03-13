extends Node2D

@export var pathsCollection: Node2D
@export var TestPathCurve: Curve

enum ENEMY_TYPES {PARADOX, ZOOLANDER, ZLOY_PARADOX}

class StageEvent:
	var enemy_type: ENEMY_TYPES
	var variation: String
	var pause: float
	var wait: bool
	
	func _init(_enemy_type: ENEMY_TYPES, _variation: String, _pause: float, _wait: bool):
		enemy_type = _enemy_type
		variation = _variation
		pause = _pause
		wait = _wait

var events: Array[StageEvent] = [
	StageEvent.new(ENEMY_TYPES.ZLOY_PARADOX, "a", 20, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "a", 0.2, false),
	StageEvent.new(ENEMY_TYPES.PARADOX, "b", 0, true),
	StageEvent.new(ENEMY_TYPES.ZOOLANDER, "a", 0, true),
	StageEvent.new(ENEMY_TYPES.ZOOLANDER, "b", 1, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "a", 1, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "b", 1, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "a", 1, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "b", 0, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "a", 0, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "b", 0, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "a", 0, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "b", 2, true),
	StageEvent.new(ENEMY_TYPES.PARADOX, "a", 2, true),
]
var stage_timer := Timer.new()
var current_event: StageEvent
#@onready var tween = get_tree().create_tween()

func _ready() -> void:
	_loop()

func _loop():
	for event in events:
		var callable = Callable.create(self, ENEMY_TYPES.keys()[event.enemy_type].to_lower())
		await callable.call(event)
		await create_tween().tween_interval(event.pause).finished
	
func paradox(event: StageEvent):
	var path = "LeftSlideAndLeave" if (event.variation == "a") else "RightSlideAndLeave"
	var follow = create_enemy_and_follow(event.enemy_type, path)
	var tween = get_tree().create_tween()
	tween.tween_property(follow, "progress_ratio", 1, 3)
	#tween.parallel().tween_interval(event.pause)
	#tween.tween_interval(event.pause)
	tween.tween_callback(follow.queue_free)
	if (not event.wait): return 1
	return tween.finished

func zoolander(event: StageEvent):
	var path = "LeftSlideAndLeave" if (event.variation == "a") else "RightSlideAndLeave"
	var follow = create_enemy_and_follow(event.enemy_type, path)
	var tween = get_tree().create_tween()
	tween.tween_property(follow, "progress_ratio", 1, 5)
	#tween.parallel().tween_interval(event.pause)
	#tween.tween_interval(event.pause)
	tween.tween_callback(follow.queue_free)
	if (not event.wait): return 1
	return tween.finished

func zloy_paradox(event: StageEvent):
	var path = "StraightAndWhite"
	var follow = create_enemy_and_follow(event.enemy_type, path)
	var tween = get_tree().create_tween()
	tween.tween_property(follow, "progress_ratio", 1, 3)
	#tween.tween_callback(follow.queue_free)
	if (not event.wait): return 1
	return tween.finished

func create_enemy_and_follow(enemy_type: ENEMY_TYPES, path: String) -> PathFollow2D:
	var enemy = ResourceLoader.load("res://Entities/Actors/Enemies/%s.tscn" % ENEMY_TYPES.keys()[enemy_type].to_lower(), "PackedScene").instantiate()
	var pathNode = pathsCollection.get_node("%s" % path)
	var pathFollow = PathFollow2D.new()
	pathFollow.loop = false
	pathFollow.rotates = false
	pathFollow.add_child(enemy)
	pathNode.add_child(pathFollow)
	enemy.path = pathFollow
	return pathFollow
