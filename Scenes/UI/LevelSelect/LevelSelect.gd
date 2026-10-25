extends ColorRect

const LEVEL_DIR := "res://Scenes/Level/Levels/"

@onready var back := $MarginContainer2/Button2
@onready var container := $MarginContainer/ColorRect/MarginContainer/HFlowContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back.pressed.connect(to_main)
	load_buttons()

func to_main() -> void:
	HUD.play_click_sfx()
	TransitionManager.transition("res://Scenes/UI/MainMenu/MainMenu.tscn")


func load_buttons() -> void:
	
	var paths :Array[String]
	
	var dir = DirAccess.open(LEVEL_DIR)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				paths.append(LEVEL_DIR + file_name.replace(".remap", ""))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	paths.sort()
	
	for i in paths.size():
		var path := paths[i]
		
		var new :FancyButton = preload("res://Scenes/UI/Button/KonpeitoButton.tscn").instantiate()
		
		new.text = digitize(i + 1, 2)
		
		container.add_child(new)
		
		new.pressed.connect(TransitionManager.transition.bind(path))
		
func digitize(i :int, digits :int) -> String:
	
	var string = str(i)
	
	while string.length() < digits:
		string = "0" + string
	
	return string
