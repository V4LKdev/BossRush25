extends Node2D
class_name EnemyController

#@export var Controller: EnemyController
#@export var Phases: Array[EnemyPhase]

var PlayerPlanet: Planet
var PlayerController: Player 

var phases: PhaseList

# Remember to call super() in base class
func _ready() -> void:
	var l = (get_node_or_null("PhaseList") as PhaseList)
	if l == null: return
	phases = l # PhaseList initializes itself
	
	getHealth().Died.connect(onHealthDepleted)
	getHealth().setMaxHealth(phases.getCurrentPhase().getPhaseHealth())
	getHealth().setHealth(phases.getCurrentPhase().getPhaseHealth())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerPlanet == null:
		PlayerController = Util.getSingleton(Util.PLAYER)
		PlayerPlanet = PlayerController.getPlanet()
		
		phases.player = PlayerController
		if PlayerController != null:
			phases.init()
		return
	
	tick(delta)

func tick(delta: float) -> void: pass # virtual

func checkPlayerValid() -> bool:
	if PlayerPlanet == null:
		PlayerController = Util.getSingleton(Util.PLAYER)
		if PlayerController == null:
			return false
		PlayerPlanet = PlayerController.getPlanet()
		return false
	return true

func onHealthDepleted():
	if phases.nextPhase():
		var p = phases.getCurrentPhase()
		var h = getHealth()
		h.setMaxHealth(p.getPhaseHealth())
		h.setHealth(p.getPhaseHealth())
	else:
		onDeath()
		

func getHealth() -> Health: # virtual
	push_error("Called EnemyController.getHealth on base class")
	return null 

func onDeath() -> void: # virtual
	push_warning("Using base impl of Enemy.onDeath()")
	queue_free()
