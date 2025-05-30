extends Node

enum Effect {CHAOS_ORB, DIVINE_ORB}
var item_effects: Array[ItemEffect] = []

func _init() -> void:
	item_effects.resize(Effect.size())
	item_effects[Effect.CHAOS_ORB] = _chaos_orb_effect()
	item_effects[Effect.DIVINE_ORB] = _divine_orb_effect()


func _chaos_orb_effect() -> ItemEffect:
	var condition: Callable = func (target) -> bool:
		return target is EquipmentItem
	var effect: Callable = func (target) -> void:
		CraftingManager.new_random_modifiers(target)
	var text: StringName = "Reforge equipment item with new random modifiers."
	return ItemEffect.create(ItemEffect.Type.CRAFTING, text, condition, effect)


func _divine_orb_effect() -> ItemEffect:
	var condition: Callable = func (target) -> bool:
		return target is EquipmentItem
	var effect: Callable = func (target) -> void:
		CraftingManager.randomize_magnitudes(target)
	var text: StringName = "Reroll magnitude values of equipment item."
	return ItemEffect.create(ItemEffect.Type.CRAFTING, text, condition, effect)
