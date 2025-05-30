class_name ItemEffect

enum Type {CRAFTING, CONSUMABLE}

var type: Type

var info: String = ""

var condition: Callable = func ():
	return false
	
var effect: Callable = func ():
	pass

static func create(type: Type, info: String, condition: Callable, effect: Callable) -> ItemEffect:
	var item_effect = ItemEffect.new()
	item_effect.type = type
	item_effect.condition = condition
	item_effect.effect = effect
	item_effect.info = info
	return item_effect
