class_name Tooltip
extends Control

@onready var _item_name: Label = %ItemName
@onready var _item_info: RichTextLabel = %ItemInfo
@onready var _info_container: PanelContainer = %InfoContainer

@export var _extended: bool

const _ATTRIBUTE_FORMAT: StringName = "[center][color=DARK_TURQUOISE]%s[/color][/center]\n"
const _STAT_FORMAT: StringName = "[center][color=GREY]%s[/color][/center]\n"
const _ATTRIBUTE_INFO_FORMAT: StringName = "[center][font_size=11][color=DARK_GREY]%s[/color][/font_size][/center]\n"
const _WEAPON_STAT_START: StringName = "[center][table=2,center]\n"
const _WEAPON_STAT_ENTRY: StringName = "[cell][left]%s[/left][/cell][cell][right]%s[/right][/cell]\n"
const _WEAPON_STAT_END: StringName = "[/table][/center]\n"



func set_item(item: Item) -> void:
	_clear()
	if item:
		if item is WeaponItem:
			_weapon_tooltip(item)
		if item is EquipmentItem:
			_equipment_tooltip(item)
		if item is EffectItem:
			_effect_tooltip(item)
		if item is SpellItem:
			_spell_tooltip(item)
	_info_container.visible = not _item_info.text.is_empty()


func _weapon_tooltip(item: WeaponItem) -> void:
	_item_info.text += _WEAPON_STAT_START
	_item_info.text += _WEAPON_STAT_ENTRY % ["Capacity", str(item.capacity)]
	_item_info.text += _WEAPON_STAT_ENTRY % ["Recharge", str(item.recharge_rate)]
	_item_info.text += _WEAPON_STAT_ENTRY % ["Cast Delay", str(item.cast_delay)]
	_item_info.text += _WEAPON_STAT_ENTRY % ["Spread", str(item.spread)]
	_item_info.text += _WEAPON_STAT_ENTRY % ["Projectile Speed", str(item.projectile_speed)]
	_item_info.text += _WEAPON_STAT_END


func _equipment_tooltip(item: EquipmentItem) -> void:
	_item_name.text = item.name
	for attribute: Attribute in item.implicits:
		_attribute_info(attribute)
	for attribute: Attribute in item.prefixes:
		_attribute_info(attribute)
	for attribute: Attribute in item.suffixes:
		_attribute_info(attribute)


func _effect_tooltip(item: EffectItem) -> void:
	_item_name.text = item.name
	_item_info.text = item.get_effect().info


func _spell_tooltip(item: SpellItem) -> void:
	_item_name.text = item.name


func _attribute_info(attribute: Attribute) -> void:
		if _extended:
			_item_info.text += _ATTRIBUTE_INFO_FORMAT % attribute.get_attribute_info_text()
		_item_info.text += _ATTRIBUTE_FORMAT % attribute.get_text(_extended)


func _clear() -> void:
	_item_name.text = ""
	_item_info.text = ""
