extends Node

class_name HealthComponent

@export var max_health: float = 100.0
@export var current_health: float = max_health

signal died

func take_damage(amount: float) -> void:
	current_health -= amount
	if current_health <= 0.0:
		current_health = 0.0
		died.emit()

func heal(amount: float) -> void:
	current_health = clamp(current_health + amount, 0.0, max_health)

func is_dead() -> bool:
	return current_health <= 0.0