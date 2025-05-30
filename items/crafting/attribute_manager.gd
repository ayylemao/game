extends Node

const ATTRIBUTE_EXTENDED_TEXT: StringName = "(%s - %s)"
const ATTRIBUTE_INFO_EXTENDED_TEXT: StringName = "%s - %s - Tier %s"

var attribute_infos: Array[AttributeInfo]

func _init() -> void:
	attribute_infos.resize(Attribute.Type.size())
	attribute_infos[Attribute.Type.INCREASED_FIRE_DAMAGE] = _increased_fire_damage_attribute()
	attribute_infos[Attribute.Type.INCREASED_HEALTH] = _increased_health_attribute()


func generate_attribute(item: EquipmentItem, pool: Array[Attribute.Type]) -> Attribute:
	var attribute_selectors: Array[_AttributeSelector] = []
	for attribute_type: Attribute.Type in pool:
		var attribute_info: AttributeInfo = attribute_infos[attribute_type]
		var tier_infos: Array[AttributeInfo.TierInfo] = attribute_info.tier_infos.filter(
				func (tier_info: AttributeInfo.TierInfo) -> bool: return tier_info.ilvl <= item.ilvl
			) 
		attribute_selectors.append_array(tier_infos.map(
			func (tier_info: AttributeInfo.TierInfo) -> _AttributeSelector:
				return _AttributeSelector.create(attribute_info, tier_info.tier, tier_info.weight)
				)
			)
	
	if attribute_selectors.is_empty():
		return null
	
	var attribute_selector: _AttributeSelector = _weighted_random(attribute_selectors)
	
	var attribute: Attribute = Attribute.new()
	attribute.magnitude = randf()
	attribute.tier = attribute_selector.tier
	attribute.type = attribute_selector.attribute_info.type
	return attribute


func _increased_fire_damage_attribute() -> AttributeInfo:
	var attribute_info := AttributeInfo.new()
	attribute_info.type = Attribute.Type.INCREASED_FIRE_DAMAGE 
	attribute_info.text = "Increase Fire-Damage by %s."
	attribute_info.tier_infos = [ 
			AttributeInfo.TierInfo.create(4, 1, 1, 5, 100), 
			AttributeInfo.TierInfo.create(3, 5, 6, 15, 100), 
			AttributeInfo.TierInfo.create(2, 10, 16, 19, 100), 
			AttributeInfo.TierInfo.create(1, 20, 20, 30, 100), 
		]
	attribute_info.tags = [AttributeInfo.Tag.FIRE]
	attribute_info.affix_type = AttributeInfo.AffixType.SUFFIX
	attribute_info.family = AttributeInfo.Family.INCREASED_FIRE
	return attribute_info


func _increased_health_attribute() -> AttributeInfo:
	var attribute_info := AttributeInfo.new()
	attribute_info.type = Attribute.Type.INCREASED_HEALTH 
	attribute_info.text = "Increase Health by %s."
	attribute_info.tier_infos = [ 
			AttributeInfo.TierInfo.create(4, 1, 1, 5, 100), 
			AttributeInfo.TierInfo.create(3, 5, 6, 15, 100), 
			AttributeInfo.TierInfo.create(2, 10, 16, 19, 100), 
			AttributeInfo.TierInfo.create(1, 20, 20, 30, 100), 
		]
	attribute_info.tags = [AttributeInfo.Tag.HEALTH]
	attribute_info.affix_type = AttributeInfo.AffixType.PREFIX
	attribute_info.family = AttributeInfo.Family.INCREASED_HEALTH
	return attribute_info


func _weighted_random(attribute_selectors: Array[_AttributeSelector]) -> _AttributeSelector:
	var total_weight: int = attribute_selectors.reduce(
		func (accum: int, attribute_selector: _AttributeSelector) -> int: 
			return accum + attribute_selector.weight,
		0
	)
	
	var random_value: int = randi_range(0, total_weight - 1)
	
	for attribute_selector: _AttributeSelector in attribute_selectors:
		random_value -= attribute_selector.weight
		if random_value < 0:
			return attribute_selector
			
	return null


class _AttributeSelector:
	var attribute_info: AttributeInfo
	var tier: int
	var weight: int
	
	static func create(attribute_info: AttributeInfo, tier: int, weight: int) -> _AttributeSelector:
		var attribute_selector: _AttributeSelector = _AttributeSelector.new()
		attribute_selector.attribute_info = attribute_info
		attribute_selector.tier = tier
		attribute_selector.weight = weight
		return attribute_selector
