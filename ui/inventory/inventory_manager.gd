extends Node

var inventory: Array[InventorySlot] = []
var equipment: Array[InventorySlot] = []
var weapon: InventorySlot
var spells: Array[InventorySlot] = []
var cursor: CursorItem
var inventory_canvas: CanvasLayer
var inventory_ui: InventoryUI

const _NUMBER_OF_INVENTORY_SLOTS: int = 21
const _ITEM_DROP_SPEED: float = 400.0
@onready var _world_item_scene: PackedScene = preload("res://items/world_item.tscn")

func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	inventory.resize(_NUMBER_OF_INVENTORY_SLOTS)


func _input(event) -> void:
	if event.is_action_pressed("ui_inventory"):
		get_tree().paused = !get_tree().paused
		inventory_canvas.visible = get_tree().paused
	if event.is_action_released("mod_shift") and cursor.state == cursor.State.EFFECT:
		cursor.clear()


func primary_click(slot: InventorySlot) -> void:
	var item: Item = slot.item
	match cursor.state:
		cursor.State.NONE:
			slot.place_item(null)
			cursor.place_item(item)
			
		cursor.State.ITEM:
			if slot.can_place_item(cursor.item):
				slot.place_item(cursor.item)
				cursor.place_item(item)
			
		cursor.State.EFFECT:
			if slot.can_apply_effect(cursor.item) and _reduce_effect_item(cursor.item):
				slot.apply_effect(cursor.item)
			if not Input.is_action_pressed("mod_shift"):
				cursor.clear()


func secondary_click(slot: InventorySlot) -> void:
	var item: Item = slot.item
	match cursor.state:
		cursor.State.NONE:
			if item is EffectItem:
				cursor.place_effect(item)
			
		cursor.State.ITEM:
			pass
			
		cursor.State.EFFECT:
			cursor.clear()


func setup_changed(inventory_slot: InventorySlot) -> void:
	if inventory_slot.item_type.has(Item.Type.WEAPON):
		inventory_ui.weapon_update(inventory_slot.item)
		
	if inventory_slot.item_type.has(Item.Type.SPELL):
		var spell_items: Array[SpellItem] = []
		spell_items.assign(spells
		.map(func (slot: InventorySlot) -> SpellItem: 
			return slot.item as SpellItem)
		)
		weapon.item.spells = spell_items
		
	_update_stats()


func _update_stats() -> void:
	var equipment_items: Array[EquipmentItem] = []
	equipment_items.assign(equipment
		.filter(func (slot: InventorySlot) -> bool: 
			return slot.item != null)
		.map(func (slot: InventorySlot) -> EquipmentItem: 
			return slot.item as EquipmentItem)
		)
		
#	Globals.player.character_stats.update_setup(
#			weapon.item if weapon else null, 
#			equipment_items
#		)


func add_item(item: Item) -> bool:
	if item.stackable and _stack_item(item): # Try to stack item
		return true
	if _new_item(item): # Try to add new item
		return true
	_spawn_item(item) # Inventory is full -> spawn back into world
	return false


func drop_item() -> void:
	if cursor.state == cursor.State.ITEM:
		_spawn_item(cursor.item)
	cursor.clear()


func _stack_item(item: Item) -> bool:
	for slot: InventorySlot in inventory:
		if (
			slot.item 
			and slot.item.id == item.id 
			and slot.item.stackable # This should be a given when the IDs are used correctly
		): 
			slot.change_quantity(item.quantity)
			return true
	return false


func _new_item(item: Item) -> bool:
	for slot: InventorySlot in inventory:
		if not slot.item:
			slot.place_item(item)
			return true
	return false


func _spawn_item(item: Item) -> void:
	var world_item: WorldItem = _world_item_scene.instantiate()
	world_item.item = item
	world_item.global_position = Globals.player.item_spawn_marker.global_position
	var impulse: Vector2 = get_viewport().get_visible_rect().get_center() \
		.direction_to(get_viewport().get_mouse_position())
	world_item.apply_impulse(impulse * _ITEM_DROP_SPEED)
	get_tree().root.add_child(world_item)


func _reduce_effect_item(item: Item) -> bool:
	for slot: InventorySlot in inventory:
		if slot.item is EffectItem and slot.item.effect_id == item.effect_id:
			slot.change_quantity(-1)
			return true
	return false
	
