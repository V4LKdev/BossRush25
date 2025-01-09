class_name Util

const PLAYER: String = "player"
#const PLAYERDEAD: String = "playerdead"

static var SingletonMap: Dictionary = {} # string -> Node2D

static func apply(obj: Node, fn: String):
	if obj != null:
		return obj.call(fn)

static func apply1(obj: Node, fn: String, arg1: Variant):
	if obj != null:
		return obj.call(fn, arg1)

static func addToScene(tree: SceneTree, n: Node):
	tree.root.call_deferred("add_child", n)

static func addSingleton(name: String, n: Variant) -> void:
	SingletonMap[name] = n

static func getSingleton(name: String) -> Variant:
	if not SingletonMap.has(name):
		return null
	return SingletonMap[name]

static func removeSingleton(name: String) -> void:
	SingletonMap.erase(name)
