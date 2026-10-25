class_name Konpeito extends Area2D
## A lil candy the soot sprite can pick up.

@onready var sprite := $Sprite
@onready var fill := $Sprite/Fill
@onready var mark := $Sprite/Mark

var collected = false

var tween :Tween

func _ready() -> void:
	randomize_pallete()
	
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(sprite, "position:y", 6.0, 1.2)
	tween.tween_property(sprite, "position:y", -6.0, 1.2)
	
	tween.set_loops()
	
	body_entered.connect(_body_entered)

func _body_entered(body :Node) -> void:
	
	if body is Soot:
		
		if collected: return
		
		
		if tween and tween.is_running():
			tween.kill()
		
		tween = create_tween().set_ease(Tween.EASE_IN)
		tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
		
		print("Collected!")
		
		collected = true
		
		HUD.update()
		
		$Pickup.play()
		$Pickup.finished.connect($Pickup.queue_free)
		$Pickup.reparent(get_viewport())
		
		## Complete level if all collected.
		if all_collected():
			TransitionManager.transition("res://Scenes/UI/LevelSelect/LevelSelect.tscn")
			
			
		

func all_collected() -> bool:
	
	for konpeito :Konpeito in get_tree().get_nodes_in_group("Konpeito"):
		if not konpeito.collected: return false
	
	return true

const COLOR_SETS :Dictionary[Color,Color] = {
	Color(0.725, 0.569, 0.859, 1.0): Color(0.451, 0.373, 0.694, 1.0),
	Color(0.592, 0.859, 0.569, 1.0): Color(0.0, 0.608, 0.533, 1.0),
	Color(0.859, 0.851, 0.569, 1.0): Color(0.431, 0.631, 0.431, 1.0),
	Color(0.859, 0.686, 0.569, 1.0): Color(0.616, 0.412, 0.416, 1.0),
	Color(0.859, 0.584, 0.569, 1.0): Color(0.561, 0.337, 0.463, 1.0)
}

func randomize_pallete() -> void:
	
	var primary := COLOR_SETS.keys().pick_random() as Color
	var secondary := COLOR_SETS[primary]
	
	sprite.color = secondary
	mark.color = secondary
	fill.color = primary
	
	
