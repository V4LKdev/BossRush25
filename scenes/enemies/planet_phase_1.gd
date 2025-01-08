extends EnemyPhase

func start() -> void: print("start1")
func tick(delta: float): pass # virtual
func end() -> void: print("end1")

# Returns how much damage he can take this phase ends, and next begins or he dies
func getPhaseHealth() -> float: # virtual
	return 2
