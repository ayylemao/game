class_name Spell
extends Resource

enum Type {PROJECTILE, MODIFIER, MULTICAST}

var type: Type
var mana_cost: int
var scene: PackedScene
var knockback: float 
var cast_delay: float 
var recharge_time: float 
var spread: float 
var multicast: int
var payload: bool

func init(_projectiles: Array[Projectile]) -> void:
	pass


func start_effect(_projectile: Projectile) -> void:
	pass


func travel_effect(_projectile: Projectile, _delta: float) -> void:
	pass


func end_effect(_projectile: Projectile) -> void:
	pass
