class_name InventorySlot
extends Control

signal primary_click(inventory_slot: InventorySlot)
signal secondary_click(inventory_slot: InventorySlot)
signal item_changed_or_modified(inventory_slot: InventorySlot)

@onready var _item_icon: TextureRect = %ItemIcon
@onready var _quantity: Label = %Quantity
#@onready var _click_timer: Timer = %ClickTimer
@onready var tooltip_manager: TooltipManager = %TooltipManager

@export var item_type: Array[Item.Type] = []
@export var equipment_type: Array[EquipmentItem.SubType] = []

var item: Item

func _ready() -> void:
	_update()

func place_item(item: Item) -> void:
	self.item = item
	_update()
	item_changed_or_modified.emit(self)


func can_place_item(item: Item) -> bool:
	return (
		item_type.is_empty() and equipment_type.is_empty() 
		or (item_type.has(item.type))
		or (item is EquipmentItem and equipment_type.has(item.sub_type))
		)


func apply_effect(item: EffectItem) -> void:
	item.get_effect().effect.call(self.item)
	_update()
	item_changed_or_modified.emit(self)


func can_apply_effect(item: EffectItem) -> bool:
	return item.get_effect().condition.call(self.item)


func change_quantity(amount: int) -> void:
	if item.quantity < 0: # Infinite
		return
	item.quantity += amount
	if item.quantity == 0:
		item = null
	_update()


func _update(): 
	if not is_node_ready():
		return
	if item:
		_item_icon.texture = item.texture
		_quantity.text = str(item.quantity) if item.stackable and item.quantity > 0 else ""
	else:
		_item_icon.texture = null
		_quantity.text = ""
	tooltip_manager.set_item(item)


func _on_interact_area_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		primary_click.emit(self)
		#print("pressed " + str(self))
		#_click_timer.start()
	#if event.is_action_released("mouse_left") and _click_timer.is_stopped() and has_focus():
		#print("release " + str(self))
		#primary_click.emit(self)
	if event.is_action_pressed("mouse_right"):
		secondary_click.emit(self)


func _on_interact_area_mouse_entered() -> void:
	#grab_focus()
	#print("focus " + str(self))
	#set_drag_preview()
	tooltip_manager.set_cursor_in_area(true)


func _on_interact_area_mouse_exited() -> void:
	tooltip_manager.set_cursor_in_area(false)
