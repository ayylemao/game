extends Node

class_name Skill

func cast(_context: SkillContext):
	pass

func stop_cast() -> void:
	pass

func apply_to_target(target: Node) -> void:
	for component in get_children():
		if component.has_method("apply"):
			component.apply(target)
