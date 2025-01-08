extends Node2D
class_name Health

signal Died() 

@export var MaxHealth: float = 10.0
@export var CurrentHealth: float = 10.0

func _ready() -> void:
	CurrentHealth = MaxHealth

func dealOneDamage():
	dealDamage(1)

# Returns the new health
func dealDamage(value: float) -> float:
	CurrentHealth -= value
	
	print(CurrentHealth, " : ", MaxHealth)
	
	if CurrentHealth <= 0:
		Died.emit()
		print("Health gone")
	
	return clamp(CurrentHealth, 0, MaxHealth)

# Returns the new health
func addHealth(value: float) -> float:
	CurrentHealth = clampf(CurrentHealth + value, 0, MaxHealth)
	return clamp(CurrentHealth, 0, MaxHealth)

func setHealth(value: float):
	CurrentHealth = clampf(value, 0, MaxHealth)

# Returns the new max health
func addMaxHealth(value: float) -> float:
	MaxHealth += value
	CurrentHealth = clamp(CurrentHealth, 0 , MaxHealth)
	return MaxHealth

func setMaxHealth(value: float) -> void:
	MaxHealth = value
	CurrentHealth = clamp(CurrentHealth, 0 , MaxHealth)
