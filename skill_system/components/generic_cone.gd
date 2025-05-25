extends Area2D
class_name GenericCone

var skill: Skill = null
var caster: Node = null
var hit_targets := {}

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	monitoring = true

	if has_node("AnimatedSprite2D"):
		$AnimatedSprite2D.play()

func _on_body_entered(body: Node) -> void:
	if body == caster or hit_targets.has(body):
		return

	hit_targets[body] = true

	if skill and skill.has_method("apply_to_target"):
		skill.apply_to_target(body)

func _on_body_exited(body: Node) -> void:
	if skill and skill.has_method("remove_target"):
		skill.remove_target(body)
