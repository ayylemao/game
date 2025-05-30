class_name Weapon
extends Node2D

@export var _character_stats: CharacterStats
@export var _owner_hurtbox: Hurtbox
@export var _target: Marker2D

@onready var _launcher: Marker2D = $Launcher
@onready var _sprite: Sprite2D = $Sprite
@onready var recharge_timer: Timer = $RechargeTimer
@onready var cast_delay: Timer = $CastDelay

var _item: WeaponItem
var _shooting: bool

var spells: Array[Spell] = []
var spell_index: int = 0


func _ready() -> void:
	_character_stats.updated.connect(_on_update)
	_on_update()


func start_shooting():
	_shooting = true
	_shoot()


func stop_shooting():
	_shooting = false


func _on_update() -> void:
	_item = _character_stats.weapon_item
	_sprite.texture = null
	if _item:
		_sprite.texture = _item.texture
		recharge_timer.wait_time = _character_stats.recharge_rate
		cast_delay.wait_time = _character_stats.cast_delay
		spells.assign(_item.spells
			.filter(func (spell_item: SpellItem) -> bool: 
				return spell_item != null)
			.map(func (spell_item: SpellItem) -> Spell: 
				return spell_item.spell as Spell)
		)


# Creates a projectile. owner_hurtbox is not getting hurt, except if the projectile has self_harm enabled
func _shoot() -> void:
	if not _item or recharge_timer.time_left > 0 or cast_delay.time_left > 0:
		return
	
	var batch: SpellBatch = SpellBatch.generate(self, 1000)
	
	if spell_index >= spells.size():
		spell_index = 0
		recharge_timer.start()
		print("Recharge")
	
	
	batch.shoot(
		_launcher.global_position, 
		_launcher.global_position.angle_to_point(_target.global_position),
		_character_stats.projectile_speed,
		_character_stats,
		_character_stats.spread,
		_owner_hurtbox
	)
	
	cast_delay.start()


func _create_attack() -> Attack:
	var attack := Attack.new()
	attack.damage = 20.0
	attack.owner_hurtbox = _owner_hurtbox
	attack.self_harm = false
	return attack


func _on_recharge_timer_timeout() -> void:
	recharge_timer.wait_time = _character_stats.recharge_rate
	if _shooting:
		_shoot()


func _on_cast_delay_timeout() -> void:
	cast_delay.wait_time = _character_stats.cast_delay
	if _shooting:
		_shoot()
