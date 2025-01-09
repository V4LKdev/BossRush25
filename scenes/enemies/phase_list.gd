extends Node2D
class_name PhaseList

var currentPhase: EnemyPhase
var player: Player

func getPhaseCount() -> int:
	return get_child_count()

func _ready() -> void:
	if getPhaseCount() == 0:
		push_error("No phases in phase list")
		return
		
	for i in getPhaseCount():
		if (get_child(i) as EnemyPhase) == null:
			push_error("Node which is not an EnemyPhase in PhaseList: ", get_child(i))
			return
	
	currentPhase = get_child(0)

func init():
	currentPhase.init(get_parent(), player)
	currentPhase.start()

func _process(delta: float) -> void:
	if currentPhase == null:
		return
	
	if player.getPlanet() == null:
		print("Player nullled")
		return
	
	currentPhase.tick(delta)

# returns true if there are more phases
func nextPhase() -> bool:
	var ct = getPhaseCount()-1
		
	currentPhase.end()
	currentPhase.queue_free()
	remove_child(currentPhase)
	if ct == 0:
		return false
	
	currentPhase = get_child(0)
	currentPhase.init(get_parent(), player)
	currentPhase.start()
	return true
	
func getCurrentPhase() -> EnemyPhase:
	return currentPhase
