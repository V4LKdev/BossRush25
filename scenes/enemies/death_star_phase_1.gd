extends EnemyPhase

var ctrl: DeathStarController

func start() -> void:
	ctrl = getController() as DeathStarController

func tick(delta: float): pass # virtual
func end() -> void: pass # virtual

func move() -> void:
	ctrl.move(playerPlanet.global_position, randf_range(500, 700))

# Returns how much damage he can take this phase ends, and next begins or he dies
func getPhaseHealth() -> float: # virtual
	return 15
