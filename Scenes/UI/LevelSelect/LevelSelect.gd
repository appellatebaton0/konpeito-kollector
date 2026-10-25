extends ColorRect

const MAIN_MENU := preload("res://Scenes/UI/MainMenu/MainMenu.tscn")

@onready var back := $MarginContainer2/Button2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(MAIN_MENU)
	back.pressed.connect(to_main)

func to_main() -> void:
	TransitionManager.transition(MAIN_MENU)
