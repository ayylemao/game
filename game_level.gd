extends Node2D

@onready var _player: Player = %Player
@onready var _inventory_canvas: CanvasLayer = %InventoryCanvas
@onready var _interact_canvas: CanvasLayer = %InteractCanvas
@onready var _inventory_ui: Control = %InventoryCanvas/InventoryUI

func _ready() -> void:
	Globals.player = _player
	InventoryManager.inventory_canvas = _inventory_canvas
	InventoryManager.inventory_ui = _inventory_ui

	InteractManager.interact_canvas = _interact_canvas
	InteractManager.interact_label = _interact_canvas.get_child(0).get_node("%Label")
