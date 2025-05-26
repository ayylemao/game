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
	bar.value = health_component.current_health
	if health_component.current_health < health_component.max_health:
		visible = true

	if has_node(".."):
		var parent = get_parent()
		var collision = parent.get_node("CollisionShape2D")
		var shape = collision.shape

		if shape is RectangleShape2D:
			var extents = shape.extents
			var y_offset = extents.y + 10
			global_position = parent.global_position - Vector2(bar.size.x / 2.0, y_offset)

func _on_died():
	queue_free()
