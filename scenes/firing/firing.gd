extends Node2D

@export var PROJECTILE: PackedScene = preload("res://scenes/firing/Projectile.tscn")
@export var ProjectileDamage: float = 1
@export var ProjectileSpeed: float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawnProjectile(dir: Vector2, pos: Vector2, damageMult: float = 1, speedMult: float = 1):
	var p = PROJECTILE.instantiate() as Projectile
	p.global_position = pos
	p.rotation = randf() * 2 * PI
	p.Damage = ProjectileDamage * damageMult
	p.MoveDir = dir
	p.MoveSpeed = ProjectileSpeed * speedMult
	
	Util.addToScene(get_tree(), p)
