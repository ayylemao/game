@icon("res://art/editor_icons/node_2D/icon_ring.png")
@tool
class_name WorldItem
extends Area2D

@onready var _interact_area: InteractArea = %InteractArea
@onready var _sprite: Sprite2D = %Sprite

@export var item: Item

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	_sprite.texture = item.texture
	_interact_area.interacted.connect(_on_interacted)
	_interact_area.text = "Pickup " + item.name + "."


func _process(_delta: float) -> void:
	if Engine.is_editor_hint() and item:
		_sprite.texture = item.texture


func _on_interacted() -> void:
	InventoryManager.add_item(item)
	queue_free()
