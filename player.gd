extends CharacterBody2D

@export var speed: float = 100
@onready var skill_loadout = $SkillLoadout

var is_casting := false

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2.ZERO

	# Read input
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# Normalize to prevent faster diagonal movement
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	if not is_casting:	
		# Move the character
		velocity = input_vector * speed
		move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		var context = SkillContext.new()
		context.caster = self
		context.target_position = get_global_mouse_position()
		context.skill_root = get_parent().get_node("ActiveProjectiles")
		skill_loadout.cast_skill(0, context)

	if Input.is_action_just_pressed("mouse_right"):
		if not is_casting:
			is_casting = true
			var context = SkillContext.new()
			context.caster = self
			context.target_position = get_global_mouse_position()
			context.skill_root = get_parent()
			skill_loadout.cast_skill(1, context)
	elif Input.is_action_just_released("mouse_right"):
		is_casting = false
		skill_loadout.stop_skill(1)
