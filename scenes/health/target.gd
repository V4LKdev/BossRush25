extends Node2D
class_name Target

signal Damaged(value: float) 

@export var AutoConnectToHealth: bool = false

func _ready() -> void:
	if AutoConnectToHealth:
		if !tryConnectToHealth():
			push_error("Could not autoconnect to health")

# returns true if it connects
func tryConnectToHealth() -> bool:
	var h = get_parent().get_node_or_null("Health") as Health
	if h == null:
		return false
	
	Damaged.connect(h.dealDamage)
	return true

func dealDamage(value: float) -> void:
	Damaged.emit(value)

# Returns true if it managed to deal the damage
static func tryDealDamage(n: Node2D, value: float) -> bool:
	var t = (n as Target)
	
	if t != null:
		t.dealDamage(value)
		return true
	else:
		var c = n.get_node_or_null("Target") 
		
		if c != null:
			c.dealDamage(value)
			return true
	
	return false 
