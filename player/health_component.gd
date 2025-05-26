extends Node
class_name HealthComponent

var stats: Stats = null
var current_health: float = 0.0
var max_health: float = 0.0

signal died

func _ready() -> void:
	stats = get_parent().get_node_or_null("Stats")
	if stats:
		current_health = stats.current_health
		max_health = stats.max_health
	else:
		push_error("StatsComponent not found as sibling of HealthComponent.")


func _process(delta: float) -> void:
	current_health = clamp(current_health + stats.health_regen_per_sec * delta, 0, max_health)

func take_damage(amount: float) -> void:
	current_health -= amount
	if current_health <= 0.0:
		current_health = 0.0
		died.emit()

func heal(amount: float) -> void:
	if stats:
		current_health = clamp(current_health + amount, 0.0, stats.max_health)

func is_dead() -> bool:
	return current_health <= 0.0