class_name AttributeInfo

enum Tag {FIRE, HEALTH}
enum Family {INCREASED_FIRE, INCREASED_HEALTH}
enum AffixType {PREFIX, SUFFIX, IMPLICIT}

var family: Family
var affix_type: AffixType
var type: Attribute.Type 
var text: StringName
var tier_infos: Array[TierInfo]
var tags: Array[Tag]


class TierInfo:
	var tier: int
	var ilvl: int
	var from: float
	var to: float
	var weight: int

	static func create(tier: int, ilvl: int, from: float, to: float, weight: int) -> TierInfo:
		var tier_info: TierInfo = TierInfo.new()
		tier_info.tier = tier
		tier_info.ilvl = ilvl
		tier_info.from = from
		tier_info.to = to
		tier_info.weight = weight
		return tier_info
