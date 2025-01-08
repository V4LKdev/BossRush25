extends Area2D

var targetPlanet: Node2D

@export var MoveSpeed: float = 3
@export var Accel: float = 1
@export var CollectionRadius: float = 100

var speed = 0.0

func _on_body_entered(body: Node2D) -> void:
	var b = body as Planet
	if (b) == null:
		return
	
	if not b.isPlayerControlled:
		return
	
	targetPlanet = body
	
func _process(delta: float) -> void:
	if targetPlanet == null:
		return
	
	speed = lerpf(speed, MoveSpeed, delta * Accel)
	global_position = lerp(global_position, targetPlanet.global_position, speed * delta)
	
	if (global_position-targetPlanet.global_position).length() < CollectionRadius:
		queue_free()
