extends Node
class_name SkillLoadout

func cast_skill(index: int, context: SkillContext) -> void:
	var skill_node := get_child(index)
	if skill_node is Skill:
		(skill_node as Skill).cast(context)
