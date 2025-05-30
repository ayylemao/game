class_name InteractArea
extends Area2D

signal interacted

var text: String = ""

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func interact() -> void:
	interacted.emit()

func on_body_entered(body: Node2D) -> void:
	if body is Player:
		InteractManager.interact_areas.append(self)

func on_body_exited(body: Node2D) -> void:
	if body is Player:
		InteractManager.interact_areas.erase(self)
