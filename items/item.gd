class_name Item
extends Resource

enum Type {CURRENCY, WEAPON, EQUIPMENT, SPELL}

@export var name: String = ""
@export var type: Type
@export var texture: Texture = null
@export var id: int = 0
@export var stackable: bool = false
@export var quantity: int = 1
