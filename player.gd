extends CharacterBody2D

@export var speed: float = 100
@onready var skill_loadout = $SkillLoadout

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2.ZERO
	
	# Read input
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Normalize to prevent faster diagonal movement
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
	
	# Move the character
	velocity = input_vector * speed
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		var context = SkillContext.new()
		context.caster = self
		context.target_position = get_global_mouse_position()
		context.projectile_root = get_parent().get_node("ActiveProjectiles")
		skill_loadout.cast_skill(0, context)
