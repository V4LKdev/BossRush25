extends Line2D

var targetDir: Vector2

const LENGTH = 10000

@export var Damage: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points[0] = Vector2.ZERO
	points[1] = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setTargetDir(dir: Vector2) -> void:
	points[1] = dir.normalized() * LENGTH
	$Ray.target_position = dir.normalized() * LENGTH

func getHit() -> Node2D:
	return $Ray.get_collider()

func fire() -> bool:
	var hit = getHit()
	if hit == null:
		return false
	
	var ok = Target.tryDealDamage(hit.get_parent(), Damage)
	
	return ok

func setTargetPos(global_pos: Vector2) -> void:
	setTargetDir(to_local(global_pos)) 

func resetTargetDir() -> void:
	points[1] = Vector2.ZERO
	$Ray.target_position = Vector2.ZERO
