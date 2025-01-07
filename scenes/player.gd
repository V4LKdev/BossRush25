extends Node2D
class_name Player

@export_category("Firing")
@export var PROJECTILE: PackedScene = preload("res://scenes/firing/Projectile.tscn")
@export var ProjectileDamage = 1.0

@export_category("Zoom")
@export var MinZoom = 0.3
@export var MaxZoom = 2.0
@export var ZoomSpeed = 1.0

@export_category("Spinning")
@export var StartSpinSpeed: float = 45
@export var SpinAccel: float = 35.0
@export var SpinTolerance: float = 180

@export_category("Population")
@export var Pops: float = 5 # round down to get actual value
@export var MaxPops: float = 5
@export var PopsRegen: float = 0.1
@export var PopulationFlingKoefficient: float = 0.1

var zoom: float = MaxZoom

func _ready() -> void:
	$Planet.SpinSpeed = StartSpinSpeed
	
	Util.addSingleton(Util.PLAYER, self)

func _process(delta: float) -> void:
	handleInput(delta)
	handleZoom(delta)
	
	if getActualPops() <= 0:
		print("He dead")
		%Cam.reparent(get_tree().root)
		queue_free()
		# Game over
		return
	
	addPops(PopsRegen * delta)
	addPops(-getPopFlingCount()*delta)
	
func getPlanet() -> Planet:
	return $Planet

func handleInput(delta: float) -> void:
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
	
	var spin: float
	if Input.is_action_pressed("q"):
		spin -= delta * SpinAccel
	if Input.is_action_pressed("e"):
		spin += delta * SpinAccel
	
	$Planet.addInput(dir)
	$Planet.addSpinInput(spin)

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
	if abs($Planet.SpinSpeed) < 5:
		print("Planet is not spinning, cant fire")
		return
	
	var target = getCursorPosition()
	
	var dist = (target-getGlobalPosition()).length()
	
	if dist < $Planet.Radius:
		return
	
	var rot = atan2(target.y - getGlobalPosition().y, target.x - getGlobalPosition().x) - (
		asin($Planet.Radius / dist) - PI/2) * sign(-$Planet.SpinSpeed)

	
	print(Vector2($Planet.Radius * cos(rot), $Planet.Radius * sin(rot)))
	
	var spawnPos = $Planet.global_position + Vector2($Planet.Radius * cos(rot), $Planet.Radius * sin(rot))
	#$Sprite2D.global_position = spawnPos
	
	var scale = abs($Planet.SpinSpeed/StartSpinSpeed)
	$Firing.spawnProjectile((target - spawnPos).normalized(), spawnPos, scale, scale)

func spawnProjectile(dir: Vector2, pos: Vector2):
	var p = PROJECTILE.instantiate() as Projectile
	p.global_position = pos
	p.rotation = randf() * 2 * PI
	p.Damage = ProjectileDamage
	p.MoveDir = dir
	
	Util.addToScene(get_tree(), p)

func getActualPops() -> int:
	return floor(Pops)

func getPopFlingCount() -> float:
	var m = (abs($Planet.SpinSpeed) - SpinTolerance)
	if m <= 0:
		return 0
	
	return m * PopulationFlingKoefficient

# Returns new popcount
func addPops(value: float) -> float:
	Pops = clampf(Pops + value, 0, MaxPops)
	return Pops

func getCursorPosition() -> Vector2:
	return $Cursor.global_position

func getGlobalPosition() -> Vector2:
	return $Planet.global_position
