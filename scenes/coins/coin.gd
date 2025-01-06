extends Area2D

var targetPlanet: Node2D

@export var MoveSpeed: float = 3
@export var Accell: float = 1
@export var CollectionRadius: float = 100

var speed = 0.0

func _on_body_entered(body: Node2D) -> void:
	if (body as Planet) == null:
		return
		
	targetPlanet = body
	
func _process(delta: float) -> void:
	if targetPlanet == null:
		return
	
	speed = lerpf(speed, MoveSpeed, delta * Accell)
	global_position = lerp(global_position, targetPlanet.global_position, speed * delta)
	
	if (global_position-targetPlanet.global_position).length() < CollectionRadius:
		print("Coin collected")
		queue_free()
