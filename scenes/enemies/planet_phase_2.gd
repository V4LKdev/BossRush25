extends EnemyPhase
class_name PlanetPhase2

func start() -> void: print("start2")
func tick(delta: float): pass # virtual
func end() -> void: print("end2")

# Returns how much damage he can take this phase ends, and next begins or he dies
func getPhaseHealth() -> float: # virtual
	return 5
