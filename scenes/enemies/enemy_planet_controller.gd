extends EnemyController
class_name EnemyPlanetController

@export_category("Orbiting")
@export var OrbitDistance: float = 800.0
@export var OrbitDistRange: float = 100.0
@export var OrbitDirSwitchTime: float = 1.0

var timeSinceSwitch: float = 0

var currentState: int 
var prevState: int

var orbitDir: int = 1 # 1 or -1 

#var PlayerPlanet: Planet
#var PlayerController: Player 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	#$Planet.getHealth().Died.connect(onDeath)
	randomizeOrbitDir()

func randomizeOrbitDir() -> void:
	orbitDir = (randi() % 2) * 2 - 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func tick(delta: float) -> void:
	#print(currentState)
	
	var dist = ($Planet.global_position - PlayerPlanet.global_position).length()
	#print(dist)
	
	if (dist < OrbitDistance) and currentState == 0:
		if prevState != currentState: 
			timeSinceSwitch = 0
	elif dist < OrbitDistance - OrbitDistRange:
		currentState = 0
		if prevState != currentState: 
			timeSinceSwitch = 0
	elif dist > OrbitDistance + OrbitDistRange:
		currentState = 1
		if prevState != currentState: 
			timeSinceSwitch = 0
	else:
		currentState = 2
		timeSinceSwitch = 0
	
	match currentState:
		0: 
			avert(delta)
		1: 
			approach(delta)
		2:
			orbit(delta)
	
	
	timeSinceSwitch += delta
	
	#if prevState != currentState: 
		#timeSinceSwitch = 0
		#print("switch")
	
	#print(timeSinceSwitch)
	
	prevState = currentState

func approach(delta: float) -> void:
	var rot = atan2(PlayerPlanet.global_position.y - $Planet.global_position.y,
		PlayerPlanet.global_position.x - $Planet.global_position.x)
	
	if timeSinceSwitch > OrbitDirSwitchTime:
		randomizeOrbitDir()
	
	$Planet.addInput(Vector2(cos(rot), sin(rot)))

func avert(delta: float) -> void:
	var rot = atan2(PlayerPlanet.global_position.y - $Planet.global_position.y,
		PlayerPlanet.global_position.x - $Planet.global_position.x)
		
	if timeSinceSwitch > OrbitDirSwitchTime:
		randomizeOrbitDir()
	
	$Planet.addInput(-Vector2(cos(rot), sin(rot)))

func orbit(delta: float) -> void:
	var rot = atan2(PlayerPlanet.global_position.y - $Planet.global_position.y,
		PlayerPlanet.global_position.x - $Planet.global_position.x) + PI/2*orbitDir*0.898 # magical constant to keep enemy from orbiting away
	
	$Planet.addInput(Vector2(cos(rot), sin(rot)))

func getHealth() -> Health:
	return $Planet.getHealth()

func getPlanet() -> Planet:
	return $Planet

func getFiring() -> Firing:
	return $Firing

func onDeath() -> void:
	print("Enemy died")
	
	queue_free()
	
