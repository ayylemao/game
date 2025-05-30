extends Skill

class_name BasicMelee

@export var attack_range: float = 20.0

func cast(context: SkillContext) -> void:
	var target_pos = context.target_position
	if not target_pos:
		return
	
	if context.caster.global_position.distance_to(target_pos) > attack_range:
		return