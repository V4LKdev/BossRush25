extends Node2D

@export var OrbitDistance: float = 800.0
@export var OrbitDistRange: float = 100.0

@export var OrbitDirSwitchTime: float = 1.0
var timeSinceSwitch: float = 0

var currentState: int 
var prevState: int

var orbitDir: int # 1 or -1

var PlayerPlanet: Planet
var PlayerController: Player 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Planet.getHealth().Died.connect(onDeath)
	randomizeOrbitDir()

func randomizeOrbitDir() -> void:
	orbitDir = (randi() % 2) * 2 - 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if PlayerPlanet == null:
		PlayerController = Util.getSingleton(Util.PLAYER)
		PlayerPlanet = PlayerController.getPlanet()
		return
	
	var dist = ($Planet.global_position - PlayerPlanet.global_position).length()
	
	if dist < OrbitDistance - OrbitDistRange:
		avert(delta) # 0
		currentState = 0
	elif dist > OrbitDistance + OrbitDistRange:
		approach(delta) # 1
		currentState = 1
		
	else:
		orbit(delta) # 2
		currentState = 2
	
	timeSinceSwitch += delta
	
	if prevState != currentState: 
		timeSinceSwitch = 0
		print("switch")
	
	print(timeSinceSwitch)
	
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
		PlayerPlanet.global_position.x - $Planet.global_position.x) + PI/2*orbitDir
	
	#var v1 = Vector2(cos(rot + PI/2), sin(rot  + PI/2))
	#var v2 = Vector2(cos(rot - PI/2), sin(rot  - PI/2))
	# #print(atan2(v.y - $Planet.linear_velocity.y, v.x - $Planet.linear_velocity.x))
	# #print(atan2(v.y, v.x), " : ", atan2($Planet.linear_velocity.y, $Planet.linear_velocity.x))
	#var v_rot1 = atan2(v1.y, v1.x)
	#var v_rot2 = atan2(v2.y, v2.x)
	#var v_vel = atan2($Planet.linear_velocity.y, $Planet.linear_velocity.x)
	#if abs(v_vel - v_rot1) < abs(v_vel - v_rot2) :
		#rot += PI/2
	#else:
		#rot -= PI/2
	
	
	$Planet.addInput(Vector2(cos(rot), sin(rot)))


func onDeath() -> void:
	print("Enemy died")
	
	queue_free()
	
