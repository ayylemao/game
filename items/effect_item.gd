class_name EffectItem
extends Item

@export var effect_id: EffectManager.Effect
	
func get_effect() -> ItemEffect:
	return EffectManager.item_effects[effect_id]
