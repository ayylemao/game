class_name Attribute
extends Resource

enum Type {ADD_FIRE_DAMAGE, INCREASED_FIRE_DAMAGE, ADD_HEALTH, INCREASED_HEALTH}

@export var type: Type
@export_range(1, 10) var tier: int
@export_range(0, 1, 0.01, "or_greater", "or_less") var magnitude: float

func get_attribute_info() -> AttributeInfo:
	return AttributeManager.attribute_infos[type]


func get_tier_info() -> AttributeInfo.TierInfo:
	return get_attribute_info().tier_infos.filter(
		func (info: AttributeInfo.TierInfo) -> bool: return info.tier == tier
	)[0]


func get_value() -> float:
	var tier_info: AttributeInfo.TierInfo = get_tier_info()
	return round(tier_info.from + (tier_info.to - tier_info.from) * magnitude)


func get_attribute_info_text() -> String:
	var attribute_info: AttributeInfo = get_attribute_info()
	return AttributeManager.ATTRIBUTE_INFO_EXTENDED_TEXT % [
			AttributeInfo.AffixType.keys()[attribute_info.affix_type], 
			Attribute.Type.keys()[attribute_info.type], 
			tier
		]


func get_text(extended: bool = false) -> String:
	var attribute_info: AttributeInfo = get_attribute_info()
	var tier_info: AttributeInfo.TierInfo = get_tier_info()
	var value: String = str(get_value())
	if extended:
		value += AttributeManager.ATTRIBUTE_EXTENDED_TEXT % [tier_info.from, tier_info.to]
	return attribute_info.text % value
