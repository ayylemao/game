extends CharacterBody2D

@onready var health: HealthComponent = $HealthComponent
@onready var target: Node2D = null
@onready var detected: bool = false
@export var move_speed: float = 50.0
@export var detection_radius := 150.0
@export var disengage_radius := 400.0
@export var stop_distance := 40.0

var _dead := false

@onready var anim: AnimationPlayer = $AnimationPlayer

func is_dead() -> bool:
	return _dead

func _ready() -> void:
	target = get_node("/root/GameLevel/Player")
	health.died.connect(_on_died)

func _on_died():
	_dead = true
	anim.play("death")
	await anim.animation_finished
	queue_free()

func _physics_process(_delta):
	if not target or not is_instance_valid(target) or _dead:
		return

	var distance = global_position.distance_to(target.global_position)
	if distance < stop_distance:
		return	
	if distance < detection_radius:
		detected = true
	elif distance > disengage_radius:
		detected = false
	var last_dir: String = "right"
	if detected:
		var direction = (target.global_position - global_position).normalized()
		if direction.x < 0:
			last_dir = "left"
		else:
			last_dir = "right"
		velocity = direction * move_speed
	else:
		velocity = Vector2.ZERO
	anim.play(last_dir)

	move_and_slide()

func take_damage(amount: float, _damage_type: String):
	health.take_damage(amount)

