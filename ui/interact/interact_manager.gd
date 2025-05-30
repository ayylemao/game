extends Node

var interact_areas: Array[InteractArea] = []
var interact_canvas: CanvasLayer
var interact_label: Label

var _distance_compare: Callable = func (a: InteractArea, b: InteractArea): 
	return a.global_position.distance_to(Globals.player.global_position) \
		< b.global_position.distance_to(Globals.player.global_position)

func _process(_delta) -> void:
	if not interact_areas.is_empty():
		interact_areas.sort_custom(_distance_compare)
		interact_label.text = interact_areas.front().text
		interact_canvas.visible = true
	else:
		interact_canvas.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and not interact_areas.is_empty():
		interact_areas.front().interact()
