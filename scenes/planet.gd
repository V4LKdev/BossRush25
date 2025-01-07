extends RigidBody2D
class_name Planet

@export var MoveSpeed: float = 200.0
@export var Accel: float = 1
@export var Decel: float = 1
@export var Radius: float = 100.0

var speed: float = 0
var moveDir = Vector2()

@export var SpinSpeed: float = 45.0 


# Call with (0,0) to reset
func addInput(v: Vector2) -> void:
	#print(v)
	#if v.x != 0:
		#moveDir.x = v.x/abs(v.x)
	#else:
		#moveDir.x = 0
	#
	#if v.y != 0:
		#moveDir.y = v.y/abs(v.y)
	#else:
		#moveDir.y = 0
	#
	#print(moveDir)
	moveDir = v
	

# 'value' needs to be multiplied with delta
func addSpinInput(value: float) -> void:
	SpinSpeed += value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	$Sprite2D.rotation_degrees += delta * SpinSpeed
	

func getTarget() -> Target:
	return $Target

func getHealth() -> Health:
	return $Health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var t = 0.0
	if moveDir.is_zero_approx():
		t = Decel
	else:
		t = Accel
		
	linear_velocity = lerp(linear_velocity, moveDir * MoveSpeed, delta * t)

func destroy():
	print("Explosion effect")
	queue_free()
