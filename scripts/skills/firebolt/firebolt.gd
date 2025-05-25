extends Area2D
class_name Fireball
@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO
var projectile_owner: Node = null

func _physics_process(delta: float) -> void:
	position += direction.normalized() * speed * delta

func _ready():
	if has_node("DespawnTimer"):
		$DespawnTimer.timeout.connect(queue_free)

func _process(delta: float) -> void:
	if has_node("Sprite2D"):
		$Sprite2D.rotate(0.1)
