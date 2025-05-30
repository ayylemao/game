extends Node2D

class_name FloatingHealthBar

@export var health_path: NodePath
@onready var health_component: HealthComponent = get_node(health_path)
@onready var bar: ProgressBar = $ProgressBar

func _ready():
	bar.max_value = health_component.max_health
	bar.value = health_component.current_health
	health_component.died.connect(_on_died)

	visible = false

func _process(_delta: float) -> void:
	# Update the health value
	bar.value = health_component.current_health

	var parent := get_parent()

	if parent.is_dead():
		visible = false
		return
	# Show only if damaged
	visible = health_component.current_health < health_component.max_health

	if not parent or not parent.has_node("CollisionShape2D"):
		return

	var collision = parent.get_node("CollisionShape2D")
	var shape = collision.shape
	var offset_y := 0.0

	if shape is RectangleShape2D:
		offset_y = shape.extents.y + 6
	elif shape is CircleShape2D:
		offset_y = shape.radius + 6
	else:
		return

	# Use relative position, not global
	var bar_width := bar.size.x
	position = Vector2(-bar_width / 2.0, -offset_y)

func _on_died():
	queue_free()
