extends Control

@onready var bar: ProgressBar = $ProgressBar
@onready var healthcomponent: HealthComponent

func _ready() -> void:
	# Load health component after scene is fully ready
	healthcomponent = get_node("/root/GameLevel/Player/HealthComponent")

	bar.show_percentage = false
	# Set up colors
	var red_bg = StyleBoxFlat.new()
	red_bg.bg_color = Color(1, 0, 0)  # Red background

	var green_fill = StyleBoxFlat.new()
	green_fill.bg_color = Color(0, 1, 0)  # Green fill

	# Override styles
	bar.add_theme_stylebox_override("background", red_bg)
	bar.add_theme_stylebox_override("fill", green_fill)

	# Initialize bar
	bar.max_value = healthcomponent.max_health
	bar.value = healthcomponent.current_health

	healthcomponent.died.connect(_on_died)

func _process(_delta: float) -> void:
	if healthcomponent:
		bar.value = healthcomponent.current_health

func _on_died():
	# Optional: hide or animate the bar on death
	bar.visible = false
