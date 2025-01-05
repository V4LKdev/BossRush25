extends Node2D
class_name Pinata

@export var MinCoins = 0
@export var MaxCoins = 5
@export var MinRadius = 50.0
@export var MaxRadius = 100.0

@export var COIN: PackedScene

func explode():
	var coinAmount = randi_range(0,0)
	
	for i in coinAmount:
		var c = COIN.instantiate() as Node2D
		
