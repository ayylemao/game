extends Node

class_name BaseStats


@export var base_attack_speed: float = 1.0
@export var base_physical_damage: float = 10.0
@export var mana_regen_per_sec: float = 1.0
@export var health_regen_per_sec: float = 0.0
@export var cast_speed: float = 1.0


@export var max_health: float = 100.0
@export var max_mana: float = 100.0


# For debug
@export var current_health := max_health
@export var current_mana := max_mana


