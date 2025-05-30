extends Node

class_name Skill

@export var cast_speed_per_second: float = 1.0
@export var base_attack_speed: float = 1.0

func cast(_context: SkillContext):
	pass

func stop_cast() -> void:
	pass

func apply_to_target(target: Node) -> void:
	for component in get_children():
		if component.has_method("apply"):
			component.apply(target)
