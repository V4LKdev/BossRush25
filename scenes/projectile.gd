extends RigidBody2D
class_name Projectile

@export var MoveSpeed = 1000
@export var Damage = 1.0
@export var Lifetime = 4

var MoveDir = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().create_timer(Lifetime).timeout.connect(queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	linear_velocity = MoveDir * MoveSpeed


func _on_body_entered(body: Node) -> void:
	print(body)
	Target.tryDealDamage(body, Damage)
	queue_free()
