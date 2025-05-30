class_name TooltipManager
extends Control

@onready var _tooltip: Tooltip = %Tooltip
@onready var _tooltip_extended: Tooltip = %TooltipExtended

var _has_item: bool
var _cursor_in_area: bool

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mod_alt"):
		_tooltip.visible = false
		_tooltip_extended.visible = true
	elif event.is_action_released("mod_alt"):
		_tooltip.visible = true
		_tooltip_extended.visible = false


func set_cursor_in_area(value: bool):
	_cursor_in_area = value
	visible = value and _has_item


func set_item(item: Item):
	_has_item = item != null
	_tooltip.set_item(item)
	_tooltip_extended.set_item(item)
	visible = _has_item and _cursor_in_area
