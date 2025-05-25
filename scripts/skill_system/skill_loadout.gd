extends Node
class_name SkillLoadout

@export var skills: Array[Skill]


func cast_skill(index: int, context: SkillContext) -> void:
	if index >= 0 and index < skills.size():
		skills[index].cast(context)
