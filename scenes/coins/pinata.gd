extends Node2D
class_name Pinata

@export var MinCoins = 0
@export var MaxCoins = 5
@export var MinRadius = 50.0
@export var MaxRadius = 100.0

@export var COIN: PackedScene = preload("res://scenes/coins/Coin.tscn")
@export var IMPULSE_MOVER = preload("res://scenes/coins/ImpulseMover.tscn")

func boom(v: float):
	explode()

func explode():
	var coinAmount = randi_range(MinCoins, MaxCoins)
	
	for i in coinAmount:
		var c = COIN.instantiate() as Node2D
		var m = IMPULSE_MOVER.instantiate() as ImpulseMover
		c.add_child(m)
		
		var radius = randf_range(MinRadius, MaxRadius)
		var rot = randf() * 2 * PI
		
		c.global_position = global_position
		m.TargetPos = global_position + Vector2(radius * cos(rot), radius * sin(rot))
				
		Util.addToScene(get_tree(), c)
		m.call_deferred("start")
	
	queue_free()
