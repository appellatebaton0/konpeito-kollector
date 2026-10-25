extends CanvasLayer
## The global transition manager.

@onready var anim_player := $AnimationPlayer

func transition(to :Variant) -> void:
	anim_player.play("TransitionIn")
	
	await anim_player.animation_finished
	
	if to is Node:
		get_tree().change_scene_to_node(to)
	elif to is PackedScene:
		get_tree().change_scene_to_packed(to)
	elif to is String:
		get_tree().change_scene_to_file(to)
	
	anim_player.play("TransitionOut")
	
	await get_tree().scene_changed
	HUD.update()
	
