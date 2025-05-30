extends Node

var _prefix_pool: Array[Attribute.Type] = [Attribute.Type.INCREASED_FIRE_DAMAGE, Attribute.Type.INCREASED_HEALTH]

func new_random_modifiers(item: EquipmentItem) -> void:
	item.prefixes.clear()
	for i in range(0, randi_range(0, 3)):
		var attribute: Attribute = AttributeManager.generate_attribute(item, _prefix_pool)
		if attribute:
			item.prefixes.append(attribute)
	
func randomize_magnitudes(item: EquipmentItem) -> void:
	for attribute: Attribute in item.prefixes:
		attribute.magnitude = randf()
	for attribute: Attribute in item.suffixes:
		attribute.magnitude = randf()
