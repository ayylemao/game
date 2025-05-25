extends Node

class_name FireElement

@export var damage: int = 20
@export var ignite_chance: float = 0.2

func apply(target: Node, _context: SkillContext) -> void:
    if target.has_method("take_damage"):
        target.take_damage(damage, "fire")