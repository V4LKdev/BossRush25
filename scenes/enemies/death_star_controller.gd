extends EnemyController
class_name DeathStarController

const IMPULSE_MOVER = preload("res://scenes/coins/ImpulseMover.tscn")
@export var FirePos: Vector2

@export var MinimumMoveDist: float = 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	

func move(centerPos: Vector2, distFromCenter: float, avoidAngle: float = 45) -> void:
	var rot: float = randf() * 2 * PI
	var target = centerPos + distFromCenter * Vector2(cos(rot), sin(rot)) 
	
	while isInAvoidAngle(target, rot, avoidAngle * PI / 180) || ($Planet.global_position - target).length() < MinimumMoveDist:
		#(centerPos + distFromCenter * Vector2(cos(rot), sin(rot))) - $Planet.global_position).length() < MinimumMoveDist:
		rot = randf() * 2 * PI
		target = centerPos + distFromCenter * Vector2(cos(rot), sin(rot))
	
	
	var i = IMPULSE_MOVER.instantiate()
	$Planet.add_child(i)
	i.TargetPos = target
	i.AnimSpeed = 0.1
	i.start()

func isInAvoidAngle(target: Vector2, rot: float, angle: float) -> bool:
	#var targetToPlayer = atan2($Planet.global_position.y - target.y, $Planet.global_position.x - target.x)
	#var playerToEnemy = atan2(PlayerPlanet.global_position.y - $Planet.global_position.y,
		#PlayerPlanet.global_position.x - $Planet.global_position.x)
	#print(targetToPlayer)
	#print(playerToEnemy)
	#print()
	#return abs(targetToPlayer - playerToEnemy - PI) < angle
	var targetToPlayer = (PlayerPlanet.global_position - target).normalized()
	var playerToEnemy = ($Planet.global_position - PlayerPlanet.global_position).normalized()
	
	
	return acos(targetToPlayer.dot(playerToEnemy)) < angle

func avoidObstacle(target: Vector2) -> bool:
	return false
	$Ray.target_position = to_local(target)
	if $Ray.is_colliding():
		return true
	
	#$Ray.target_position = Vector2(t.x * cos(5) + t.y * -sin(5),t.x * sin(5) + t.y * cos(5))
	#if $Ray.is_colliding():
		#return true
		#
	#$Ray.target_position = Vector2(t.x * cos(-5) + t.y * -sin(-5),t.x * sin(-5) + t.y * cos(-5))
	#if $Ray.is_colliding():
		#return true
		
	
	return false 

func tick(delta: float) -> void: 
	if PlayerPlanet == null:
		return
	
	#%DeathLaser.setTargetPos(PlayerPlanet.global_position)

func getHealth() -> Health: # virtual
	return $Planet.getHealth()

func onDeath() -> void: # virtual
	print("Death star died")
	queue_free()
