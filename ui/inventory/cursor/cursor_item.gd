class_name CursorItem
extends Control

@onready var _effect_texture: TextureRect = %EffectTexture
@onready var _item_texture: TextureRect = %ItemTexture

enum State {NONE, ITEM, EFFECT}
var state: State = State.NONE
var item: Item = null

func _ready() -> void:
	clear()

func _process(_delta: float) -> void:
	position = get_global_mouse_position()
	
func place_item(item: Item) -> void:
	self.item = item
	if item:
		_item_texture.texture = item.texture
		state = State.ITEM
	else:
		clear()
		
func place_effect(item: EffectItem) -> void:
	self.item = item
	if item:
		_effect_texture.texture = item.texture
		state = State.EFFECT
	else:
		clear()
	
func clear() -> void:
	item = null
	_item_texture.texture = null
	_effect_texture.texture = null
	state = State.NONE
