extends Skill
class_name Projectile
@export var projectile_scene: PackedScene

var projectile_owner: Node = null

func cast(context: SkillContext):
	var proj = projectile_scene.instantiate()
	proj.global_position = context.caster.global_position
	proj.direction = (context.target_position - proj.global_position).normalized()
	proj.projectile_owner = context.caster

	context.projectile_root.add_child(proj)
