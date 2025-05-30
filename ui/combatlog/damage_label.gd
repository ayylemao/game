class_name DamageLabel
extends RichTextLabel

var _attacks: Array[Attack]
var _string_format: StringName = "[center]%s[/center]"


func add_attack(attack: Attack) -> void:
	_attacks.append(attack)
	var total_damage: float = _attacks.reduce(
		func (accum: float, attack: Attack) -> float: 
			return accum + attack.damage,
		0
	)
	text = _string_format % str(total_damage)


func _process(delta: float) -> void:
	position.y -= 12.5 * delta
	modulate.a -= 0.5 * delta
	if modulate.a <= 0:
		queue_free()
