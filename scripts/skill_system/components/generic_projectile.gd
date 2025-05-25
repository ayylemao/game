extends Area2D

class_name Projectile

@export var speed: float = 600.0
@export var rot_speed: float = 1.0

var direction: Vector2 = Vector2.ZERO
var projectile_owner: Node = null
var skill: Skill = null

func _ready() -> void:
    connect("body_entered", Callable(self, "_on_body_entered"))
    
    if has_node("DespawnTimer"):
        $DespawnTimer.timeout.connect(Callable(self, "_on_despawn_timeout"))

func _physics_process(delta: float) -> void:
    position += direction.normalized() * speed * delta

func _process(_delta: float) -> void:
    $Sprite2D.rotate(rot_speed)

func _on_body_entered(body: Node) -> void:
    if body != projectile_owner and skill:
        if skill.has_method("apply_to_target"):
            skill.apply_to_target(body)
            queue_free()

func _on_despawn_timeout():
    queue_free()