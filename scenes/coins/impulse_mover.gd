extends Node2D
class_name ImpulseMover

@export var TargetPos: Vector2
@export var AnimSpeed: float = 1
#@export var InitialSpeed: float = 1000

var startPos: Vector2

func start():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(get_parent(), "global_position", TargetPos, AnimSpeed)
