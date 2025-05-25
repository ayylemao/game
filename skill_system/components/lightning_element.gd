extends Node

class_name LightningElement

@export var damage: float = 20
@export var shock_chance: float = 0.2

func apply(target: Node) -> void:
    if target.has_method("take_damage"):
        target.take_damage(damage, "lightning")