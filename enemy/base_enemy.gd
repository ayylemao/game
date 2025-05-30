extends CharacterBody2D

@onready var health: HealthComponent = $HealthComponent
@onready var target: Node2D = null
@onready var detected: bool = false
@export var move_speed: float = 50.0
@export var detection_radius := 150.0
@export var disengage_radius := 400.0
@export var stop_distance := 40.0

var _dead := false
var _last_played_anim := ""
var _casting := false

@onready var _anim: AnimationPlayer = $AnimationPlayer
@onready var _stats: BaseStats = $BaseStats
@onready var _skill_loadout: SkillLoadout = null
var _time_since_last_cast : float = 0.0

func is_dead() -> bool:
	return _dead

func _ready() -> void:
	target = get_node("/root/GameLevel/Player")
	health.died.connect(_on_died)
	if has_node("SkillLoadout"):
		_skill_loadout = $SkillLoadout

func _on_died():
	_dead = true
	z_index = 1
	$CollisionShape2D.set_deferred("disabled", true)
	_anim.play("death")
	await _anim.animation_finished
	queue_free()

func _on_cast_fire():
	var context = SkillContext.new()
	context.caster = self
	context.target_position = target.global_position
	context.skill_root = get_node("/root/GameLevel/ActiveProjectiles")
	_skill_loadout.cast_skill(0, context)	
	_last_played_anim = ""

func _cast():
	_casting = true
	var pre_cast_delay = randf()
	await get_tree().create_timer(pre_cast_delay).timeout

	if _dead:
		_casting = false
		return

	if _last_played_anim == "right":
		_anim.play("cast_right")
	else:
		_anim.play("cast_left")
	await _anim.animation_finished
	_casting = false
	_time_since_last_cast = 0.0


func _physics_process(delta):
	_time_since_last_cast += delta
	if not target or not is_instance_valid(target) or _dead or _casting:
		return


	var distance = global_position.distance_to(target.global_position)
	if distance < stop_distance:
		velocity = Vector2.ZERO
		return	

	if distance < detection_radius:
		detected = true
	elif distance > disengage_radius:
		detected = false

	var can_attack := false
	var direction := Vector2.ZERO
	var anim_to_play := "right"


	if detected:
		direction = (target.global_position - global_position).normalized()
		velocity = direction * move_speed
		anim_to_play = "left" if direction.x < 0.0 else "right"
		can_attack = true
	else:
		velocity = Vector2.ZERO

	# Movement
	move_and_slide()

	# Animation
	if anim_to_play != _last_played_anim:
		_anim.play(anim_to_play)
		_last_played_anim = anim_to_play

	# Attack logic
	if _skill_loadout != null:
		var effective_interval := _stats.cast_speed
		if can_attack and _time_since_last_cast >= effective_interval:
			_cast()

func take_damage(amount: float, _damage_type: String):
	health.take_damage(amount)
