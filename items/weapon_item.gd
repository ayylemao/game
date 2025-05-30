class_name WeaponItem
extends EquipmentItem

@export var projectile_speed: float = 200.0
@export var recharge_rate: float = 0.5
@export var cast_delay: float = 0.5
@export var capacity: int = 5
@export var spread: float = 10.0
@export var spells: Array[SpellItem] = []

func _ready() -> void:
	spells.resize(capacity)
