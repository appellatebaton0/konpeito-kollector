extends ColorRect

@onready var start := $MarginContainer/PanelContainer/VBoxContainer2/VBoxContainer/Start
@onready var quitter := $MarginContainer/PanelContainer/VBoxContainer2/VBoxContainer/Quit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	start.pressed.connect(to_levels)
	quitter.pressed.connect(quit)

func to_levels() -> void:
	TransitionManager.transition("res://Scenes/UI/LevelSelect/LevelSelect.tscn")

func quit() -> void:
	get_tree().quit()
