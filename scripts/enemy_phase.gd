extends Node2D
class_name EnemyPhase

var playerPlanet: Planet
var playerController: Player 
var controller: EnemyController

func init(ctrl: EnemyController, player: Player) -> void:
	print("helo")
	playerController = player
	playerPlanet = player.getPlanet()
	controller = ctrl

func start() -> void: pass # virtual
func tick(delta: float): pass # virtual
func end() -> void: pass # virtual

# Returns how much damage he can take this phase ends, and next begins or he dies
func getPhaseHealth() -> float: # virtual
	push_error("Called getPhaseHealth() on base class")
	return 1

func getController() -> EnemyController:
	return controller
