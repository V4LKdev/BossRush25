extends Node2D
class_name Player

@export var PROJECTILE: PackedScene = preload("res://scenes/Projectile.tscn")
@export var ProjectileDamage = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Vector2()

	if Input.is_action_pressed("up"):
		dir.y -= 1
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("right"):
		dir.x += 1
		
	if Input.is_action_just_pressed("fire"):
		handleFire()
		
	var target = getCursorPosition()
	
	var rot = atan2(target.y - global_position.y, target.x - global_position.x)
	- asin($Planet.Radius / (target-global_position).length())
	
	var spawnPos = $Planet.global_position
	+ Vector2($Planet.Radius * cos(rot), $Planet.Radius * sin(rot))
	
	$Sprite2D.global_position = spawnPos
	
	$Planet.addInput(dir)
	
func handleFire():
	var target = getCursorPosition()
	
	var rot = atan2(target.y - global_position.y, target.x - global_position.x)
	- asin($Planet.Radius / (target-global_position).length())
	
	var spawnPos = $Planet.global_position
	+ Vector2($Planet.Radius * cos(rot), $Planet.Radius * sin(rot))
	
	spawnProjectile((target - global_position).normalized(), spawnPos)
	
	
func spawnProjectile(dir: Vector2, pos: Vector2):
	var p = PROJECTILE.instantiate() as Projectile
	p.global_position = pos
	p.rotation = randf() * 2 * PI
	p.Damage = ProjectileDamage
	p.MoveDir = dir
	
	Util.addToScene(get_tree(), p)

func getCursorPosition() -> Vector2:
	return $Cursor.global_position
