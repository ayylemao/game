extends CharacterBody2D

@onready var health: HealthComponent = $HealthComponent
@onready var target: Node2D = null
@onready var detected: bool = false
@export var move_speed: float = 50.0
@export var detection_radius := 150.0
@export var disengage_radius := 400.0
@export var stop_distance := 40.0


func _ready() -> void:
	target = get_node("/root/GameLevel/Player")
	health.died.connect(_on_died)

func _on_died():
	queue_free()

func _physics_process(_delta):
	if not target or not is_instance_valid(target):
		return

	var distance = global_position.distance_to(target.global_position)
	if distance < stop_distance:
		return	
	if distance < detection_radius:
		detected = true
	elif distance > disengage_radius:
		detected = false

	if detected:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * move_speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func take_damage(amount: float, _damage_type: String):
	health.take_damage(amount)
	print(health.current_health)

