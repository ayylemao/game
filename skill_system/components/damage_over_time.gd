extends Node
class_name DamageOverTime

@export var tick_damage: float = 5.0
@export var tick_interval: float = 0.5
@export var damage_type: String = "generic"

var active_targets := {}

func apply(target: Node) -> void:
	if target not in active_targets:
		active_targets[target] = true
		_apply_dot(target)

func remove_target(target: Node) -> void:
	active_targets.erase(target)

func _apply_dot(target: Node) -> void:
	var tick_time := 0.0
	while target in active_targets and is_instance_valid(target):
		await get_tree().process_frame
		tick_time += get_process_delta_time()

		if tick_time >= tick_interval:
			tick_time = 0.0
			if target.has_method("take_damage"):
				target.take_damage(tick_damage, damage_type)

	# Clean up if the loop exits naturally
	active_targets.erase(target)
