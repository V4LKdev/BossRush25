extends EnemyPhase

var planet: Planet
@export var FireTime: float = 2
@export var Damage: float = 1

var fireTimer: float = 0

func start() -> void: 
	print("start1")
	planet = (controller as EnemyPlanetController).getPlanet()
	
func tick(delta: float): 
	fireTimer += delta
	
	if fireTimer > FireTime:
		fire(delta)
		fireTimer = 0
		

func fire(delta: float) -> void:
	var spawnPos = planet.getFiringPos(playerPlanet.global_position)
	var firing = controller.getFiring()
	
	firing.spawnProjectile((playerPlanet.global_position - spawnPos).normalized(), 
		spawnPos, Damage)

func end() -> void: print("end1")

# Returns how much damage he can take this phase ends, and next begins or he dies
func getPhaseHealth() -> float: # virtual
	return 2
