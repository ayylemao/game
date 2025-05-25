extends Skill


@export var projectile_scene: PackedScene

func cast(context: SkillContext) -> void:
	var projectile = projectile_scene.instantiate()	
	projectile.global_position = context.caster.global_position
	projectile.direction = (context.target_position - projectile.global_position).normalized()
	projectile.skill = self
	projectile.caster = context.caster

	context.skill_root.add_child(projectile)
