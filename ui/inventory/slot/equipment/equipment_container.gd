class_name EquipmentContainer
extends HBoxContainer

@onready var equipment_slot: InventorySlot = $EquipmentSlot
@onready var equipment_label: Label = $EquipmentLabel

@export var text: String
@export var equipment_type: Array[EquipmentItem.SubType] = []


func _ready() -> void:
	equipment_label.text = text
	equipment_slot.item_type = [Item.Type.EQUIPMENT]
	equipment_slot.equipment_type = equipment_type
