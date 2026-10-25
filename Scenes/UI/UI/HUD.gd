extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	
	$MarginContainer/Button2.pressed.connect(TransitionManager.transition.bind("res://Scenes/UI/LevelSelect/LevelSelect.tscn"))
	
func update() -> void:
	
	visible = get_tree().current_scene.name == "LevelBase"
	
	var collected :int = 0
	var total :int = 0
	
	for konpeito:Konpeito in get_tree().get_nodes_in_group("Konpeito"):
		total += 1
		
		if konpeito.collected:
			collected += 1
	
	$MarginContainer/Label.text = str(collected) + " / " + str(total)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and visible:
		TransitionManager.transition("res://Scenes/UI/LevelSelect/LevelSelect.tscn")
