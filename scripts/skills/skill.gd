extends Resource
class_name Skill

@export var name: String
@export var icon: Texture
@export var base_cooldown: float

func cast(context: SkillContext) -> void:
	push_warning("Base Skill does nothing")
