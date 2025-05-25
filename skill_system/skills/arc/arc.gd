extends Skill

@export var cone_scene: PackedScene

var active_cone: Node = null

func cast(context: SkillContext) -> void:
	var cone = cone_scene.instantiate()
	cone.global_position = context.caster.global_position
	cone.look_at(context.target_position)
	cone.skill = self
	cone.caster = context.caster
	context.skill_root.add_child(cone)

	active_cone = cone

func stop_cast() -> void:
	if active_cone:
		active_cone.queue_free()
		active_cone = null

func apply_to_target(target: Node) -> void:
	for child in get_children():
		if child.has_method("apply"):
			child.apply(target)

func remove_target(target: Node) -> void:
	for child in get_children():
		if child.has_method("remove_target"):
			child.remove_target(target)
