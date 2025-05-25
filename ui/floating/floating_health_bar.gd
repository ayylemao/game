extends Node2D

class_name FloatingHealthBar

@export var health_path: NodePath
@onready var health_component: HealthComponent = get_node(health_path)
@onready var bar: ProgressBar = $ProgressBar

func _ready():
	bar.max_value = health_component.max_health
	bar.value = health_component.current_health
	health_component.died.connect(_on_died)

	visible = true

func _process(_delta: float) -> void:
	bar.value = health_component.current_health

	if has_node(".."):
		global_position = get_parent().global_position + Vector2(-bar.size.x/2.0, -23)

func _on_died():
	queue_free()
