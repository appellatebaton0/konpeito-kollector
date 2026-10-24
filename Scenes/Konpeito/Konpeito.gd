class_name Konpeito extends Area2D
## A lil candy the soot sprite can pick up.

@onready var sprite := $Sprite

var collected = false

var tween :Tween

func _ready() -> void:
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween().set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(sprite, "position:y", 6.0, 1.2)
	tween.tween_property(sprite, "position:y", -6.0, 1.2)
	
	tween.set_loops()
	
	body_entered.connect(_body_entered)

func _body_entered(body :Node) -> void:
	
	if body is Soot:
		
		if tween and tween.is_running():
			tween.kill()
		
		tween = create_tween().set_ease(Tween.EASE_IN)
		tween.tween_property(self, "scale", Vector2.ZERO, 0.5)
		
		print("Collected!")
		
		collected = true
		
		## Complete level if all collected.
		if all_collected():
			pass

func all_collected() -> bool:
	
	for konpeito :Konpeito in get_tree().get_nodes_in_group("Konpeito"):
		if not konpeito.collected: return false
	
	return true
