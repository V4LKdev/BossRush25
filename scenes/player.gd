extends Node2D
class_name Player

@export var PROJECTILE: PackedScene = preload("res://scenes/Projectile.tscn")
@export var ProjectileDamage = 1.0

@export var MinZoom = 0.3
@export var MaxZoom = 2.0
@export var ZoomSpeed = 1.0

var zoom: float = MaxZoom

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
	
	handleZoom(delta)
	
	$Planet.addInput(dir)

func handleZoom(delta: float) -> void:
	var t = 0
	if Input.is_action_just_released("scrollup"):
		t = 1
	elif Input.is_action_just_released("scrolldown"):
		t = -1
	
	zoom = clampf(zoom + t * delta * 3, MinZoom, MaxZoom)
	%Cam.zoom.x = lerpf(%Cam.zoom.x, zoom, ZoomSpeed * delta)
	%Cam.zoom.y = lerpf(%Cam.zoom.y, zoom, ZoomSpeed * delta)

func handleFire():
	var target = getCursorPosition()
	
	var dist = (target-getGlobalPosition()).length()
	
	if dist < $Planet.Radius:
		return
	
	var rot = atan2(target.y - getGlobalPosition().y, target.x - getGlobalPosition().x) - (
		asin($Planet.Radius / dist)) + PI/2
	
	
	print(Vector2($Planet.Radius * cos(rot), $Planet.Radius * sin(rot)))
	
	var spawnPos = $Planet.global_position + Vector2($Planet.Radius * cos(rot), $Planet.Radius * sin(rot))
	#$Sprite2D.global_position = spawnPos
	
	spawnProjectile((target - spawnPos).normalized(), spawnPos)

func spawnProjectile(dir: Vector2, pos: Vector2):
	var p = PROJECTILE.instantiate() as Projectile
	p.global_position = pos
	p.rotation = randf() * 2 * PI
	p.Damage = ProjectileDamage
	p.MoveDir = dir
	
	Util.addToScene(get_tree(), p)

func getCursorPosition() -> Vector2:
	return $Cursor.global_position

func getGlobalPosition() -> Vector2:
	return $Planet.global_position
