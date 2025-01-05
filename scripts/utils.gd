class_name Util

static func apply(obj: Node, fn: String):
	if obj != null:
		return obj.call(fn)

static func apply1(obj: Node, fn: String, arg1: Variant):
	if obj != null:
		return obj.call(fn, arg1)

static func addToScene(tree: SceneTree, n: Node):
	tree.root.call_deferred("add_child", n)
