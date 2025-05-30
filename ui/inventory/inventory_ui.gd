class_name InventoryUI
extends Control

@onready var inventory_grid: GridContainer = %InventoryGrid
@onready var equipment_grid: VBoxContainer = %EquipmentGrid
@onready var weapon_display: WeaponDisplay = %WeaponDisplay
@onready var cursor: Control = %CursorItem

var _inventory_slot_scene: PackedScene = preload("res://ui/inventory/slot/inventory_slot.tscn")

func _ready() -> void:
	InventoryManager.cursor = cursor
	
	InventoryManager.weapon = weapon_display.weapon_slot
	_connect_inventory_events(weapon_display.weapon_slot)
	
	for i: int in InventoryManager.inventory.size():
		InventoryManager.inventory[i] = _inventory_slot_scene.instantiate()
		_connect_inventory_events(InventoryManager.inventory[i])
		inventory_grid.add_child(InventoryManager.inventory[i])
		
	for equipment_container: EquipmentContainer in equipment_grid.get_children():
		_connect_inventory_events(equipment_container.equipment_slot)
		InventoryManager.equipment.append(equipment_container.equipment_slot)


func weapon_update(weapon: WeaponItem) -> void:
	for inventory_slot: InventorySlot in weapon_display.spell_slots.get_children():
		inventory_slot.queue_free()
	
	if not weapon:
		return

	InventoryManager.spells.resize(weapon.capacity)
	for i: int in InventoryManager.spells.size():
		InventoryManager.spells[i] = _inventory_slot_scene.instantiate()
		InventoryManager.spells[i].item_type = [Item.Type.SPELL]
		InventoryManager.spells[i].place_item(weapon.spells[i] if weapon.spells.size() > i else null)
		_connect_inventory_events(InventoryManager.spells[i])
		weapon_display.spell_slots.add_child(InventoryManager.spells[i])


func _connect_inventory_events(inventory_slot: InventorySlot) -> void:
		inventory_slot.primary_click.connect(InventoryManager.primary_click)
		inventory_slot.secondary_click.connect(InventoryManager.secondary_click)
		inventory_slot.item_changed_or_modified.connect(InventoryManager.setup_changed)


func _on_outside_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left"):
		InventoryManager.drop_item()
