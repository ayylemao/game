class_name EquipmentItem
extends Item

enum SubType {WAND, HELMET, CHEST, BOOTS, RING, LEGS, TRINKET, CAPE}

@export var sub_type: SubType
@export_range(1, 100) var ilvl: int
@export_group("Attributes")
@export var implicits: Array[Attribute] = []
@export var prefixes: Array[Attribute] = []
@export var suffixes: Array[Attribute] = []

func _init() -> void:
	stackable = false
	quantity = 1


func get_all_attributes() -> Array[Attribute]:
	var attributes: Array[Attribute] = []
	attributes.append_array(implicits)
	attributes.append_array(prefixes)
	attributes.append_array(suffixes)
	return attributes
