class_name Camera extends Camera2D

@export var target :Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not target: return
	
	var t := 1.0 - pow(2, -delta / 0.25)
	
	global_position = global_position.slerp(target.global_position, t)
