extends RigidBody2D
class_name Planet

@export var MoveSpeed: float = 200.0
@export var Accel: float = 1
@export var Decel: float = 1
@export var Radius: float = 100.0

var speed: float = 0
var moveDir = Vector2()

@export var SpinSpeed: float = 45.0 

var isPlayerControlled: bool = false

# Call with (0,0) to reset
func addInput(v: Vector2) -> void:
	moveDir = v

# 'value' needs to be multiplied with delta
func addSpinInput(value: float) -> void:
	SpinSpeed += value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	$Sprite2D.rotation_degrees += delta * SpinSpeed
	
	$Sprite2D2.global_position = global_position + moveDir.normalized() * 60
	

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

func getFiringPos(cursorPos: Vector2) -> Vector2: #Array: # [Vector2 firingPos, bool isValid]
	var dist = (cursorPos-global_position).length()
	
	#if dist < Radius:
		#return [Vector2(), false]
	
	var rot = atan2(cursorPos.y - global_position.y, cursorPos.x - global_position.x) - (
		asin(Radius / dist) - PI/2) * sign(-SpinSpeed)
	
	var pos = global_position + Vector2(Radius * cos(rot), Radius * sin(rot))
	return pos

func destroy():
	print("Explosion effect")
	queue_free()
