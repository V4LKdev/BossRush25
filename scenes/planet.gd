extends RigidBody2D
class_name Planet

@export var MoveSpeed = 200.0
@export var Accel = 1
@export var Decel = 1
@export var Radius = 100.0

var speed = 0
var moveDir = Vector2()

# Call with (0,0) to reset
func addInput(v: Vector2) -> void:
	moveDir = v

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var t = 0.0
	if moveDir.is_zero_approx():
		t = Decel
	else:
		t = Accel
		
	linear_velocity = lerp(linear_velocity, moveDir * MoveSpeed, delta * t)
