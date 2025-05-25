extends Node
class_name SkillLoadout

func cast_skill(index: int, context: SkillContext) -> void:
	var skill_node := get_child(index)
	if skill_node is Skill:
		(skill_node as Skill).cast(context)

func stop_skill(index: int) -> void:
	if index >= 0 and index < get_child_count():
		var skill = get_child(index)
		if skill.has_method("stop_cast"):
			skill.stop_cast()
